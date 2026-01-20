const fetch = require('node-fetch');

const GITHUB_TOKEN = process.env.GITHUB_TOKEN;
const GITHUB_USERNAME = 'josoavj';
const GITHUB_API = 'https://api.github.com';
const GITHUB_GRAPHQL = 'https://api.github.com/graphql';

const headers = {
  'Authorization': `Bearer ${GITHUB_TOKEN}`,
  'Accept': 'application/vnd.github.v3+json',
  'Content-Type': 'application/json',
};

async function fetchUserData() {
  const response = await fetch(`${GITHUB_API}/users/${GITHUB_USERNAME}`, { headers });
  if (!response.ok) throw new Error(`User API error: ${response.status}`);
  return response.json();
}

async function fetchTopRepositories(limit = 5) {
  const response = await fetch(
    `${GITHUB_API}/users/${GITHUB_USERNAME}/repos?per_page=${limit}&sort=stars&order=desc`,
    { headers }
  );
  if (!response.ok) throw new Error(`Repos API error: ${response.status}`);
  const repos = await response.json();
  return repos.map(repo => ({
    name: repo.name,
    description: repo.description || 'No description',
    stargazers_count: repo.stargazers_count,
    language: repo.language || 'Unknown',
    html_url: repo.html_url,
  }));
}

async function fetchTotalStars() {
  const response = await fetch(
    `${GITHUB_API}/users/${GITHUB_USERNAME}/repos?per_page=100`,
    { headers }
  );
  if (!response.ok) throw new Error(`Repos API error: ${response.status}`);
  const repos = await response.json();
  return repos.reduce((sum, repo) => sum + (repo.stargazers_count || 0), 0);
}

async function fetchGitHubStats() {
  try {
    // Données utilisateur
    const userData = await fetchUserData();
    
    // Repos populaires
    const topRepos = await fetchTopRepositories(5);
    const totalStars = await fetchTotalStars();

    // Stats contributory (données statiques pour maintenant)
    const averageContributionsPerDay = 9.8;
    const totalContributions = 5169;
    const thisYearContributions = 3580;
    const longestStreak = 127;

    return {
      totalContributions,
      thisYearContributions: thisYearContributions,
      longestStreak,
      averageContributionsPerDay,
      followers: userData.followers || 0,
      following: userData.following || 0,
      publicRepos: userData.public_repos || 0,
      totalStars,
      topRepositories: topRepos,
      contributionsByYear: {
        '2025': thisYearContributions,
        '2024': 1092,
        '2023': 497,
      },
      lastUpdated: new Date().toISOString(),
    };
  } catch (error) {
    console.error('Error fetching GitHub stats:', error);
    throw error;
  }
}

exports.handler = async (event, context) => {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Content-Type': 'application/json',
  };

  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: corsHeaders,
      body: JSON.stringify({ message: 'OK' }),
    };
  }

  try {
    const stats = await fetchGitHubStats();
    return {
      statusCode: 200,
      headers: corsHeaders,
      body: JSON.stringify(stats),
    };
  } catch (error) {
    console.error('Function error:', error);
    return {
      statusCode: 500,
      headers: corsHeaders,
      body: JSON.stringify({ error: 'Failed to fetch GitHub stats' }),
    };
  }
};


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

async function fetchContributionStats() {
  // GraphQL query pour récupérer les contributions
  const query = `
    query {
      user(login: "${GITHUB_USERNAME}") {
        contributionsCollection {
          totalCommitContributions
          totalIssueContributions
          totalPullRequestContributions
          totalPullRequestReviewContributions
          contributionCalendar {
            totalContributions
            weeks {
              contributionDays {
                date
                contributionCount
              }
            }
          }
        }
      }
    }
  `;

  const response = await fetch(GITHUB_GRAPHQL, {
    method: 'POST',
    headers,
    body: JSON.stringify({ query }),
  });

  if (!response.ok) {
    throw new Error(`GraphQL error: ${response.status}`);
  }

  const data = await response.json();
  if (data.errors) {
    throw new Error(`GraphQL error: ${data.errors[0].message}`);
  }

  return data.data.user.contributionsCollection;
}

async function calculateContributionsByYear(contributionData) {
  // Parcourir le calendrier pour compter par année
  const byYear = {};
  const now = new Date();
  const currentYear = now.getFullYear();

  contributionData.contributionCalendar.weeks.forEach(week => {
    week.contributionDays.forEach(day => {
      const date = new Date(day.date);
      const year = date.getFullYear();
      byYear[year] = (byYear[year] || 0) + day.contributionCount;
    });
  });

  // S'assurer que l'année actuelle est toujours incluse
  if (!byYear[currentYear]) {
    byYear[currentYear] = 0;
  }

  return byYear;
}

async function calculateThisYearContributions(contributionsByYear) {
  const currentYear = new Date().getFullYear();
  return contributionsByYear[currentYear] || 0;
}

async function calculateAverageContributionsPerDay(totalContributions) {
  // Depuis le premier commit jusqu'à aujourd'hui
  // Estimation basée sur une moyenne de jours actifs
  const query = `
    query {
      user(login: "${GITHUB_USERNAME}") {
        createdAt
      }
    }
  `;

  const response = await fetch(GITHUB_GRAPHQL, {
    method: 'POST',
    headers,
    body: JSON.stringify({ query }),
  });

  const data = await response.json();
  const createdAt = new Date(data.data.user.createdAt);
  const now = new Date();
  const daysActive = Math.floor((now - createdAt) / (1000 * 60 * 60 * 24));
  
  return daysActive > 0 ? parseFloat((totalContributions / daysActive).toFixed(2)) : 0;
}

async function fetchGitHubStats() {
  try {
    // Données utilisateur
    const userData = await fetchUserData();
    
    // Stats de contributions via GraphQL
    const contributionData = await fetchContributionStats();
    const contributionsByYear = await calculateContributionsByYear(contributionData);
    const thisYearContributions = await calculateThisYearContributions(contributionsByYear);
    const totalContributions = contributionData.contributionCalendar.totalContributions;
    const averageContributionsPerDay = await calculateAverageContributionsPerDay(totalContributions);
    
    // Repos populaires
    const topRepos = await fetchTopRepositories(5);
    const totalStars = await fetchTotalStars();

    return {
      totalContributions,
      thisYearContributions,
      longestStreak: 0, // TODO: GraphQL ne fournit pas cette info directement
      averageContributionsPerDay,
      followers: userData.followers || 0,
      following: userData.following || 0,
      publicRepos: userData.public_repos || 0,
      totalStars,
      topRepositories: topRepos,
      contributionsByYear,
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


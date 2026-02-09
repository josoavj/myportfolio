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
    `${GITHUB_API}/users/${GITHUB_USERNAME}/repos?per_page=100&sort=stars&order=desc`,
    { headers }
  );
  if (!response.ok) throw new Error(`Repos API error: ${response.status}`);
  const repos = await response.json();
  return repos
    .slice(0, limit)
    .map(repo => ({
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

async function fetchTopLanguages(limit = 5) {
  const response = await fetch(
    `${GITHUB_API}/users/${GITHUB_USERNAME}/repos?per_page=100`,
    { headers }
  );
  if (!response.ok) throw new Error(`Repos API error: ${response.status}`);
  const repos = await response.json();
  
  const languages = {};
  for (const repo of repos) {
    if (repo.language && repo.language !== null) {
      languages[repo.language] = (languages[repo.language] || 0) + 1;
    }
  }
  
  return Object.entries(languages)
    .sort((a, b) => b[1] - a[1])
    .slice(0, limit)
    .map(([lang, count]) => ({ name: lang, count }));
}

async function fetchContributionStats() {
  // Récupérer les contributions de toutes les années (depuis le début du compte)
  const years = [];
  const currentYear = new Date().getFullYear();
  
  // Ajouter les années depuis 2015 (moment où GitHub a commencé à tracker les contributions)
  for (let year = 2015; year <= currentYear; year++) {
    years.push(year);
  }

  let allContributions = [];
  
  // Récupérer les contributions année par année
  for (const year of years) {
    const from = `${year}-01-01T00:00:00Z`;
    const to = `${year}-12-31T23:59:59Z`;
    
    const query = `
      query {
        user(login: "${GITHUB_USERNAME}") {
          contributionsCollection(from: "${from}", to: "${to}") {
            contributionCalendar {
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

    try {
      const response = await fetch(GITHUB_GRAPHQL, {
        method: 'POST',
        headers,
        body: JSON.stringify({ query }),
      });

      if (!response.ok) continue;

      const data = await response.json();
      if (data.errors) continue;

      const weeks = data.data.user.contributionsCollection.contributionCalendar.weeks;
      weeks.forEach(week => {
        week.contributionDays.forEach(day => {
          allContributions.push(day);
        });
      });
    } catch (e) {
      console.error(`Error fetching contributions for ${year}:`, e);
    }
  }

  // Récupérer aussi les totaux globaux
  const globalQuery = `
    query {
      user(login: "${GITHUB_USERNAME}") {
        contributionsCollection {
          totalCommitContributions
          totalIssueContributions
          totalPullRequestContributions
          totalPullRequestReviewContributions
        }
      }
    }
  `;

  const response = await fetch(GITHUB_GRAPHQL, {
    method: 'POST',
    headers,
    body: JSON.stringify({ query: globalQuery }),
  });

  if (!response.ok) {
    throw new Error(`GraphQL error: ${response.status}`);
  }

  const data = await response.json();
  if (data.errors) {
    throw new Error(`GraphQL error: ${data.errors[0].message}`);
  }

  return {
    ...data.data.user.contributionsCollection,
    allContributionDays: allContributions,
  };
}

async function calculateContributionsByYear(contributionData) {
  // Parcourir tous les jours de contributions pour compter par année
  const byYear = {};

  if (contributionData.allContributionDays && Array.isArray(contributionData.allContributionDays)) {
    contributionData.allContributionDays.forEach(day => {
      const date = new Date(day.date);
      const year = date.getFullYear();
      byYear[year] = (byYear[year] || 0) + day.contributionCount;
    });
  }

  // Filtrer pour exclure les années avec zéro contributions
  const filteredByYear = {};
  Object.entries(byYear).forEach(([year, count]) => {
    if (count > 0) {
      filteredByYear[year] = count;
    }
  });

  return filteredByYear;
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
    
    // Calculer le total des contributions depuis le début
    const totalContributions = Object.values(contributionsByYear).reduce((sum, val) => sum + val, 0);
    const averageContributionsPerDay = await calculateAverageContributionsPerDay(totalContributions);
    
    // Repos populaires
    const topRepos = await fetchTopRepositories(5);
    const totalStars = await fetchTotalStars();
    const topLanguages = await fetchTopLanguages(5);

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
      topLanguages,
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


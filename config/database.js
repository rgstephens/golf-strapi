module.exports = ({ env }) => ({
  defaultConnection: 'default',
  connections: {
    default: {
      connector: 'bookshelf',
      settings: {
        client: 'postgres',
        host: env('DATABASE_HOST', 'strapi-postgresql'),
        port: env.int('DATABASE_PORT', 5432),
        database: env('DATABASE_NAME', 'strapi'),
        username: env('DATABASE_USERNAME', 'strapi'),
        password: env('DATABASE_PASSWORD', '6B8V3BIc1U0b4crSxJV0qDdfQ1cCQuRD7sLruEWOAT8IIxTrcG'),
        ssl: env.bool('DATABASE_SSL', false),
      },
      options: {}
    },
  },
});

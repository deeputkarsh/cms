/**
 * resume-user service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::resume-user.resume-user');

/**
 * resume-user controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::resume-user.resume-user', () => ({
  async find(ctx) {
    const { data } = await super.find(ctx);
    const restructred = data.map(({ id, attributes }) => ({ id, ...attributes }));
    return restructred;
  },
  async findOne(ctx) {
    const populateQuery = { populate: { list: { populate: '*' } } };
    ctx.query = {
      ...ctx.query,
      populate: {
        personalDetails: { populate: '*' },
        achievementsData: populateQuery,
        corporateExpData: populateQuery,
        projectsData: populateQuery,
        educationData: populateQuery,
        techStackData: populateQuery,
      },
    };

    // Calling the default core action
    const { data } = await super.findOne(ctx);

    return data.attributes;
  },
}));

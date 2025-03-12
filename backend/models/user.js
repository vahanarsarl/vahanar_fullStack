'use strict';
const { Model } = require('sequelize');
const bcrypt = require('bcryptjs');

module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    static associate(models) {
      // define association here
    }
    static async hashPassword(password) {
      return await bcrypt.hash(password, 10);
    }

    async validPassword(password) {
      return await bcrypt.compare(password, this.password);
    }
  }
  User.init({
    fullName: {
      type: DataTypes.STRING,
      allowNull: false
    },
    phone: {
      type: DataTypes.STRING,
      allowNull: false
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'User',
  });

  User.addHook('beforeCreate', async (user) => {
    user.password = await User.hashPassword(user.password);
  });

  return User;
};''
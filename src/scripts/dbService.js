/**
 * Api of database operation
 * Created by skz on 2016/12/22 0022.
 */
const dbApi = {

  // update app item
  update (app){
    "use strict";
    const row = appTable.createRow(app);
    bootDb.insertOrReplace().into(appTable).values([row]).exec();
  },

  // add an app
  create (app,callback){
    const row = appTable.createRow(app);
    bootDb.insertOrReplace().into(appTable).values([row]).exec().then((row) => {
      callback && callback(row[0]);
    });
  },

  // remove app
  remove (app){
    bootDb.delete().from(appTable).where(appTable.id.eq(app.id)).exec();
  },

  // get by name
  getByName(appname,callback){
    "use strict";
    return bootDb.select().from(appTable).where(appTable.name.eq(appname)).exec();
  },

  // get by name
  getById(appId,callback){
    "use strict";
    return bootDb.select().from(appTable).where(appTable.id.eq(appId)).exec();
  }

};

export { dbApi }

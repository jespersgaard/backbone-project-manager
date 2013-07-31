var project_mgr = project_mgr || {};

(function() {
	'use strict';


	var Workspace = Backbone.Router.extend({

            routes: {
                "projects"                      : "projectList",
                "login/:username/:password"     : "login",
                "logs/:id"                      : "projectLogs",
                "bugs/:id"                      : "projectBugs",
                "specs/:id"                     : "projectSpecs",
                "projects/:project_name"        : "addProject"
            },
                
            projectList: function() {
                var projectList = new project_mgr.ProjectCollection();
                projectList.fetch({success: function(){
                    project_mgr.ProjectListView = new project_mgr.ProjectListView({model: projectList});
                }});
            },
            //this following is not being used right now because it wasn't working
            //instead I'm using login.php
            login: function() {
                    project_mgr.LoginView.model.fetch({success: function(){
                        project_mgr.LoginView.closeLoginDialog();
                        project_mgr.ProjectRouter.navigate('projects', true);
                },
                    error: function () {
                        alert('An error occurred while trying login.');
                    } 
                });
            },

            projectLogs: function(proj_id) {
                var project  = project_mgr.ProjectListView.model.where({ project_id: proj_id }); 

                //Each project id is unique so only one model will be returned from where
                //which is why the first array element is explicity set on the following line.
                project[0].logs.fetch({success: function(){
//                            project_mgr.ProjectLogsView = new project_mgr.ProjectLogsView({model: project[0].logs});
                        if(project_mgr.projectLogsView != undefined)
                            project_mgr.projectLogsView.remove();

                        project_mgr.projectLogsView = new project_mgr.ProjectLogsView({model: project[0].logs});

                },
                error: function () {
                    alert('An error occurred loading project data.');
                } 

                });
            },
            projectBugs: function(proj_id) {
                var project  = project_mgr.ProjectListView.model.where({ project_id: proj_id }); 

                //Each project id is unique so only one model will be returned from where
                //which is why the first array element is explicity set on the following line.
                project[0].bugs.fetch({success: function(){
//                            project_mgr.ProjectLogsView = new project_mgr.ProjectLogsView({model: project[0].logs});
                        if(project_mgr.projectBugsView != undefined)
                            project_mgr.projectBugsView.remove();

                        project_mgr.projectBugsView = new project_mgr.ProjectBugsView({model: project[0].bugs});

                },
                error: function () {
                    alert('An error occurred loading project data.');
                } 

                });
            },
            projectSpecs: function(proj_id) {
                var project  = project_mgr.ProjectListView.model.where({ project_id: proj_id }); 

                //Each project id is unique so only one model will be returned from where
                //which is why the first array element is explicity set on the following line.
                project[0].specs.fetch({success: function(){
//                            project_mgr.ProjectLogsView = new project_mgr.ProjectLogsView({model: project[0].logs});
                        if(project_mgr.projectSpecsView != undefined)
                            project_mgr.projectSpecsView.remove();

                        project_mgr.projectSpecsView = new project_mgr.ProjectSpecsView({model: project[0].specs});

                },
                error: function () {
                    console.log('An error occurred loading project data.');
                } 

                });
            },            
            addProject: function(project_name){
                console.log('in router addProject method.');
                project_mgr.projectModel = new project_mgr.Project({project_name: project_name});
                project_mgr.projectModel.save(null, {success: function(){
                    //Now that we have a project_id set the urlRoot with this
                    //project_id in attachProjectCollections
                    project_mgr.projectModel.attachProjectCollections();
                    project_mgr.ProjectListView.model.add(project_mgr.projectModel);
                    var newSelectOption = new project_mgr.ProjectListItemView({model: project_mgr.projectModel});
                    newSelectOption.render();
                },
                error: function () {
                    console.log('An error occurred while trying to add the project.');
                } 
                });
            }
	});

	project_mgr.ProjectRouter = new Workspace();
	Backbone.history.start();

}());

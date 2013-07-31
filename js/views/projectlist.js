var project_mgr = project_mgr || {};


$(function() {
	'use strict';
        
        project_mgr.ProjectListItemView = Backbone.View.extend({

            el: "#project_names",
            
            template: _.template( $('#project-item-template').html() ),

            initialize: function () {
                 //use these if we decide to implement renaming and deleting of 
                 //projects
//                this.model.bind("change", this.render, this);
//                this.model.bind("destroy", this.close, this);
            },

            render: function () {
                $(this.el).append(this.template(this.model.toJSON()));
                console.log(this.template(this.model.toJSON()));
                console.log(this.el);
                return this;
            }
        });      
        
        project_mgr.ProjectListView = Backbone.View.extend({

                el: '#project_select',
                
		template: _.template( $('#project-list-template').html() ),

		events: {
			'click #new_project':           'openProjectDialog',
                        'click #cancel_new_button':     'closeProjectDialog',
                        'click #create_project_button':    'createProject',
                        'change #project_names':        'changeProject'
		},


		initialize: function() {
                        var dialogWidth = $('#create_project_dialog').width();  
                        $('#create_project_dialog').css('left', -dialogWidth/2 + 'px');
    
                        this.render();
                },

                render: function () {
                    $(this.el).prepend(this.template());
                    var projects = this.model.models;
                    var len = projects.length;
                    for(var i = 0; i < len; i++){
//                        $(this.el).append(new project_mgr.ProjectListItemView({model: projects[i]}).render().el);
                        new project_mgr.ProjectListItemView({model: projects[i]}).render();
                    }
                    return this;
                },       
		openProjectDialog: function(evt) {
                    evt.preventDefault();
                    $('#create_project_dialog').css('visibility', 'visible');
        
		},
                        
                closeProjectDialog: function(){
                    $('#create_project_dialog').css('visibility', 'hidden');        
                },
                        
                createProject: function(evt){
                    evt.preventDefault();
                    console.log('in create project');
                    var project_name = $('#project_name').val();
                    if(project_name.length == 0){
                        alert('No name entered');
                    } else {
                        $('#create_project_dialog').css('visibility', 'hidden');   
//                        project_mgr.ProjectRouter.navigate('projects/' + project_name, true);

                        project_mgr.projectModel = new project_mgr.Project({project_name: project_name});
                        project_mgr.projectModel.save(null, {success: function(){
                            //Now that we have a project_id set the urlRoot with this
                            //project_id in attachProjectCollections
                            project_mgr.projectModel.attachProjectCollections();
                            project_mgr.ProjectListView.model.add(project_mgr.projectModel);
                            new project_mgr.ProjectListItemView({model: project_mgr.projectModel}).render();
                            
                            $('#project_names').val(project_mgr.projectModel.get('project_id'));
                            project_mgr.ProjectListView.changeProject();
                        },
                        error: function () {
                            console.log('An error occurred while trying to add the project.');
                        } 
                        });

                    }
                },
                        
                changeProject: function() {
                    console.log('in change project');
                    var projectId = $('#project_names').val();
                    $('#main').show();
                    
                    project_mgr.ProjectRouter.navigate('logs/' + projectId, true);
                    project_mgr.ProjectRouter.navigate('bugs/' + projectId, true);
                    project_mgr.ProjectRouter.navigate('specs/' + projectId, true);
                }

	});
        
});



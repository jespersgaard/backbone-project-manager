var project_mgr = project_mgr || {};

$(function() {
	'use strict';

        project_mgr.LoginView = Backbone.View.extend({

                el: '#login',
                
		template: _.template( $('#login-template').html() ),

		events: {
                        'click #login_button':          'performLogin',
                        'click #cancel_login_button':      'cancelLogin',
                        'change #user_password':             'passwordChange',
                        'change #username':             'usernameChange'
		},

		initialize: function() {
                    this.model = new project_mgr.User();
                    this.render();
		},
                passwordChange: function() {
                    this.model.set('password', $("#user_password").val());
                },
                usernameChange: function() {
                    this.model.set('username', $("#username").val());
                },
                cancelLogin: function(){
                    $('#login_dd').toggleClass('open');
                },
                performLogin: function(evt) {
                    evt.preventDefault();
                    
                    var self = this;
                    this.model.fetch({
                        success: function(){
                            var loggedIn = "<span id='logged_in'>logged in as " + self.model.get('username') + "</span>";
                            $('#login_dd').html(loggedIn);
                            
                            var projectList = new project_mgr.ProjectCollection();
                            projectList.fetch({success: function(){
                                project_mgr.ProjectListView = new project_mgr.ProjectListView({model: projectList});
                            }});                            
//                            project_mgr.ProjectRouter.navigate('projects', false);
                        },
                        error: function () {
                            alert('An error occurred while trying login');
                        }                            
                        });
                },
		render: function() {
                        $(this.el).prepend(this.template(this.model.toJSON()));

		}

	});
});



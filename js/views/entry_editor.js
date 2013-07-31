project_mgr.EntryEditorView = Backbone.View.extend({

        template: _.template( $('#log-editor-template').html() ),

        events: {
                'click #save_entry_button':    'saveEntry',
                'click #cancel_entry_button':  'cancelEntry'
                
        },
        initialize: function(){
            var currentDate = this.getCurrentDate();
            var project_id = $('#project_names').val();
            this.model = new project_mgr.Log({date: currentDate, project_id: project_id });
        },
        render: function () {
            $(this.el).html(this.template(this.model.toJSON()));
            return this;
        },
        
        getCurrentDate: function () {
            var currentDate = new Date();
            var month = currentDate.getMonth() + 1;
            var day = currentDate.getDate();

            if(day.length === 1){
                day = "0" + day;
            }

            var year = new String(currentDate.getFullYear());

            var twoDigitYear = year.slice(2);
            var dateString = month + "-" + day + "-" + twoDigitYear;

            return dateString;
         },

        saveEntry: function(e){
            e.preventDefault();

            $(this.el).closest('.btn-group').toggleClass('open');//closes the dropdown dialog

            var entry = $(this.el).find('.log_entry').val();
            this.model.set('entry_text', entry);
            var self = this;
            this.model.save(null, {success: function(){

                    //get the currently selected project model and then get the 
                    //logs collection that is stored in that model.
                    var project  = project_mgr.ProjectListView.model.where({ project_id: self.model.get('project_id') }); 
                    project[0].logs.add(self.model);

                    var logItemView = new project_mgr.ProjectLogItemView({model: self.model});
                    project_mgr.projectLogsView.addNewChildView(logItemView);
                },
                error: function () {
                    console.log('An error occurred while trying to save the log.');
                } 
                });
        },
        cancelEntry: function(){
            $(this.el).closest('.btn-group').toggleClass('open');
        }

});


project_mgr.BugEditorView = project_mgr.EntryEditorView.extend({

        template: _.template( $('#bug-editor-template').html() ),
                
        initialize: function(){
            var currentDate = this.getCurrentDate();
            var project_id = $('#project_names').val();
            this.model = new project_mgr.Bug({date_opened: currentDate, project_id: project_id });
        },

        saveEntry: function(e){
            e.preventDefault();

            $(this.el).closest('.btn-group').toggleClass('open');//closes the dropdown dialog

            var entry = $(this.el).find('.bug_entry').val();
            this.model.set('entry', entry);
            var notes = $(this.el).find('.notes').val();
            this.model.set('notes', notes);
            var self = this;
            this.model.save(null, {success: function(){

                    //get the currently selected project model and then get the 
                    //logs collection that is stored in that model.
                    var project  = project_mgr.ProjectListView.model.where({ project_id: self.model.get('project_id') }); 
                    project[0].bugs.add(self.model);

                    var bugItemView = new project_mgr.ProjectBugItemView({model: self.model});
                    project_mgr.projectBugsView.addNewChildView(bugItemView);

                },
                error: function () {
                    console.log('An error occurred while trying to save the log.');
                } 
                });
        },

});

project_mgr.SpecEditorView = project_mgr.EntryEditorView.extend({

        template: _.template( $('#spec-editor-template').html() ),
                
        initialize: function(){
            var project_id = $('#project_names').val();
            this.model = new project_mgr.Spec({project_id: project_id });
        },

        saveEntry: function(e){
            e.preventDefault();

            $(this.el).closest('.btn-group').toggleClass('open');//closes the dropdown dialog

            var entry = $(this.el).find('.spec_entry').val();
            this.model.set('spec', entry);
            var notes = $(this.el).find('.notes').val();
            this.model.set('notes', notes);
            var self = this;
            this.model.save(null, {success: function(){

                    //get the currently selected project model and then get the 
                    //specs collection that is stored in that model so I can add
                    //this new model to it.
                    var project  = project_mgr.ProjectListView.model.where({ project_id: self.model.get('project_id') }); 
                    project[0].specs.add(self.model);

                    var specItemView = new project_mgr.ProjectSpecItemView({model: self.model});
                    project_mgr.projectSpecsView.addNewChildView(specItemView);
                },
                error: function () {
                    console.log('An error occurred while trying to save the log.');
                } 
                });
        },

});


project_mgr.EntryEditorButton = Backbone.View.extend({
        el: '#editor_nav',
        
        template: _.template( $('#entry-editor-button').html() ),
        
         events: {
             'click #open_editor_button':        'openEditor'
         },
         
         entryEditor: null,
         
         initialize: function(){
            $(this.el).html(this.template());    
         },
                 
        openEditor: function(){
            if($('#entry_editor').is(':hidden')){
                console.log('in openEditor');
                var activeTab = $( "#tabs" ).tabs( "option", "active" );
                if(this.entryEditor != null)
                    this.entryEditor.remove();
                switch (activeTab) {
    //                  logs
                    case 0:
                        this.entryEditor = new project_mgr.EntryEditorView();
                    break;
    //                  bugs
                    case 1:
                        this.entryEditor = new project_mgr.BugEditorView();
                    break;
    //                  specs
                    case 2:
                        this.entryEditor = new project_mgr.SpecEditorView();
                    break;
                }
                
                $(this.el).find('#entry_editor').append(this.entryEditor.render().el);
                
            }
        }

});

project_mgr.EntryEditorView = Backbone.View.extend({

//        el: '#entry_editor',

        logTemplate: _.template( $('#log-editor-template').html() ),
        bugTemplate: _.template( $('#bug-editor-template').html() ),
        specTemplate: _.template( $('#spec-editor-template').html() ),

    //        bug_template: _.template( $('#bug-editor-template').html() ),

//        templates: new Array(), 
        
        events: {
                'click #save_entry_button':    'saveEntry',
                'click #cancel_entry_button':    'cancelEntry'
                
        },

        render: function () {
            var activeTab = $( "#tabs" ).tabs( "option", "active" );
            console.log('clicked open editor while form is hidden and active tab is: ' + activeTab);
            var currentDate = this.getCurrentDate();
            var project_id = $('#project_names').val();
            switch (activeTab) {
//                  logs
                case 0:
                    this.model = new project_mgr.Log({date: currentDate, project_id: project_id });
                    $(this.el).html(this.logTemplate(this.model.toJSON()));
                break;
//                  bugs
                case 1:
                    this.model = new project_mgr.Bug({date_opened: currentDate, project_id: project_id });
                    $(this.el).html(this.bugTemplate(this.model.toJSON()));
                break;
//                  specs
                case 2:
                    this.model = new project_mgr.Spec({project_id: project_id });
                    $(this.el).html(this.specTemplate(this.model.toJSON()));
                break;
            }
                
//            $(this.el).html(this.templates[activeTab](this.model.toJSON()));
            
            return this;
        },
        
        getCurrentDate: function () {
            var currentDate = new Date();
            var month = currentDate.getMonth() + 1;
            var day = currentDate.getDate();

            if(day.length === 1){
                day = "0" + day;
            }
        //      needed to create a new string object here because apparently
        //      getFullYear returns a number and not a string and I need a string
        //      in order for the slice function to work.  
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
                    
                    console.log('saved the log.');

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

//        el: '#entry_editor',

        template: _.template( $('#bug-editor-template').html() ),

        render: function () {
            var activeTab = $( "#tabs" ).tabs( "option", "active" );
            console.log('opening bug tab');
            var currentDate = this.getCurrentDate();
            var project_id = $('#project_names').val();
            switch (activeTab) {
//                  logs
                case 0:
                    this.model = new project_mgr.Log({date: currentDate, project_id: project_id });
                    $(this.el).html(this.logTemplate(this.model.toJSON()));
                break;
//                  bugs
                case 1:
                    this.model = new project_mgr.Bug({date_opened: currentDate, project_id: project_id });
                    $(this.el).html(this.bugTemplate(this.model.toJSON()));
                break;
//                  specs
                case 2:
                    this.model = new project_mgr.Spec({project_id: project_id });
                    $(this.el).html(this.specTemplate(this.model.toJSON()));
                break;
            }
                
//            $(this.el).html(this.templates[activeTab](this.model.toJSON()));
            
            return this;
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
                    
                    console.log('saved the log.');

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
         entryEditor: 'null',
         
         initialize: function(){
            $(this.el).html(this.template());    
//            project_mgr.EntryEditorView = new project_mgr.EntryEditorView({el: $(this.el).find('#entry_editor')});
//            project_mgr.EntryEditorView.render();
         },
                 
        openEditor: function(){
//            if($('#new_entry_form').is(':hidden')){
            if($('#entry_editor').is(':hidden')){
                //this will render the form based on the active tab
                console.log('in openEditor');
//                entryEditor = new project_mgr.EntryEditorView({el: $(this.el).find('#entry_editor')});
                
                var activeTab = $( "#tabs" ).tabs( "option", "active" );
                var project_id = $('#project_names').val();
                switch (activeTab) {
    //                  logs
                    case 0:
                        entryEditor = new project_mgr.EntryEditorView();
                    break;
    //                  bugs
                    case 1:
                        entryEditor = new project_mgr.BugEditorView();
                    break;
    //                  specs
                    case 2:
                        this.model = new project_mgr.Spec({project_id: project_id });
                        $(this.el).html(this.specTemplate(this.model.toJSON()));
                    break;
                }
                
                $(this.el).find('#entry_editor').append(entryEditor.render().el);
                
            } else{
                entryEditor.remove();
            }
        }

});

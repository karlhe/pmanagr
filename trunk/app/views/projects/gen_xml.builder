xml.chart(:dateFormat => 'dd/mm/yyyy', :outputDateFormat => 'ddds mns yy', :ganttWidthPercent => '68', :canvasBorderColor => '999999', :canvasBorderThickness => '0', :gridBorderColor => '006600', :gridBorderAlpha => '20', :ganttPaneDuration => @hours, :ganttPaneDurationUnit => 'h', :showTaskNames=>'1'){
  xml.categories(:bgColor => '009900'){
    xml.category(:start => @project.start_time.strftime("%d/%m/%Y"), :end => Date.new(@project.due_by.month == 12 ? @project.due_by.year+1: @project.due_by.year, (@project.due_by.to_date>>1).month, 1).strftime("%d/%m/%Y"), :label => 'Timeline', :fontColor => 'ffffff', :fontSize => '16')
  }
  xml.categories(:bgColor=>'ffffff', :fontColor=>'1288dd', :fontSize=>'10', :isBold=>'1', :align=>'center'){
    monthBeg = Date.new(@project.start_time.year, @project.start_time.month, 1)
    yearBeg = Date.new(@project.start_time.year+1, 1, 1)
    xml.category(:start=>monthBeg.strftime("%d/%m/%Y"), :end=>yearBeg.strftime("%d/%m/%Y"), :label=>monthBeg.year)
    while yearBeg>>12 <= @project.due_by.to_date
      nextYearBeg = yearBeg>>12
      xml.category(:start=>yearBeg.strftime("%d/%m/%Y"), :end=>nextYearBeg.strftime("%d/%m/%Y"), :label=>yearBeg.year)
      yearBeg = yearBeg>>12
    end
    monthBeg = Date.new(@project.due_by.month == 12 ? @project.due_by.year+1: @project.due_by.year, (@project.due_by.to_date>>1).month, 1)
    xml.category(:start=>yearBeg.strftime("%d/%m/%Y"), :end=>monthBeg.strftime("%d/%m/%Y"), :label=>monthBeg.year-1)
  }
  xml.categories(:bgColor=>'ffffff', :fontColor=>'1288dd', :fontSize=>'10', :isBold=>'1', :align=>'center'){
    d = Date.new(@project.start_time.year, @project.start_time.month, 1)>>1
    xml.category(:start=>@project.start_time.strftime("%d/%m/%Y"), :end=>(d-1).strftime("%d/%m/%Y"), :label=>Date::MONTHNAMES[@project.start_time.month])
    while d <= @project.due_by.to_date
      d2 = (d>>1)-1
      xml.category(:start=>d.strftime("%d/%m/%Y"), :end=>d2.strftime("%d/%m/%Y"), :label=>Date::MONTHNAMES[d.month])
      d = d>>1
    end
  }
  xml.categories(:bgColor=>'ffffff', :fontColor=>'1288dd', :fontSize=>'10', :isBold=>'1', :align=>'center'){
    d = @project.start_time.to_date
     while d < Date.new(@project.due_by.month == 12 ? @project.due_by.year+1: @project.due_by.year, (@project.due_by.to_date>>1).month, 1)
      xml.category(:start=>d.strftime("%d/%m/%Y"), :end=>(d+1).strftime("%d/%m/%Y"), :label=>d.mday.to_s)
      d = d + 1
    end
  } if @hours <= 780
  xml.processes(:headerText=>'Task', :fontColor=>'000000', :fontSize=>'11', :isAnimated=>'1', :bgColor=>'006600', :headerVAlign=>'bottom', :headerAlign=>'left', :headerbgColor=>'006600', :headerFontColor=>'ffffff', :headerFontSize=>'16', :align=>'left', :isBold=>'1', :bgAlpha=>'25') {
    for task in @tasks
      xml.process(:label => task.name[0,18], :id => task.id, :link => project_task_url(task.project, task))
      for assignment in task.assignments
          xml.process(:label => "-" + assignment.name[0,18], :id => task.id.to_s + "-" + assignment.id.to_s, :link => project_task_assignment_url(task.project, task, assignment))
      end
    end
  }
  xml.dataTable(:showProcessName => '1', :nameAlign => 'left', :fontColor => '000000', :fontSize => '10', :vAlign => 'right', :align => 'center', :headerVAlign => 'bottom', :headerAlign => 'left', :headerbgColor => '006600', :headerFontColor => 'ffffff', :headerFontSize => '16'){
    xml.dataColumn(:bgColor=>'eeeeee', :headerText=>'Start'){
      for task in @tasks
        xml.text(:label => task.start_time.strftime("%m/%d/%y"))
        for assignment in task.assignments
          xml.text(:label => assignment.start_time.strftime("%m/%d/%y"))
        end
      end
    }
    xml.dataColumn(:bgColor=>'eeeeee', :headerText=>'Finish'){
      for task in @tasks
        xml.text(:label => task.due_by.strftime("%m/%d/%y"))
        for assignment in task.assignments
          xml.text(:label => assignment.due_by.strftime("%m/%d/%y"))
        end
      end
    }
  }
  xml.tasks(:width => '10'){
    for task in @tasks
      xml.task(:label => task.name, :processId=> task.id, :start=> task.start_time.strftime("%d/%m/%Y"), :end=> task.due_by.strftime("%d/%m/%Y"), :id=>task.id, :color=>'6B8E23', :height=>'50%', :showAsGroup =>'1', :link => project_task_url(task.project, task))
      for assignment in task.assignments
        adTime = Time.now - 8*60*60
        if adTime  > assignment.start_time - 1
          per = 100 * (Time.now - 60*60*24 - assignment.start_time)/(assignment.due_by - assignment.start_time)
          col = 'FF0000'
          xml.task(:label => assignment.name, :processId=>task.id.to_s + "-" + assignment.id.to_s, :start=> assignment.start_time.strftime("%d/%m/%Y"), :end=> (Time.now).strftime("%d/%m/%Y"), :id=>task.id.to_s + "-" + assignment.id.to_s, :color=>col, :height=>'50%', :link => project_task_assignment_url(task.project, task, assignment))
          xml.task(:label => assignment.user ? assignment.user.name : "", :processId=>task.id.to_s + "-" + assignment.id.to_s, :start=> (Time.now).strftime("%d/%m/%Y"), :end=> assignment.due_by.strftime("%d/%m/%Y"), :id=>task.id.to_s + "-" + assignment.id.to_s, :color=> '4567aa', :height=>'50%', :link => project_task_assignment_url(task.project, task, assignment))
        else
          col = '4567aa'
          per = 100
          xml.task(:label => assignment.user ? assignment.user.name : "", :processId=>task.id.to_s + "-" + assignment.id.to_s, :start=> assignment.start_time.strftime("%d/%m/%Y"), :end=> assignment.due_by.strftime("%d/%m/%Y"), :id=>task.id.to_s + "-" + assignment.id.to_s, :color=>col, :height=>'50%', :link => project_task_assignment_url(task.project, task, assignment))
        end
      end
    end
  }
  xml.connectors{
    for task in @tasks
      for dep in task.dependencies
        xml.connector(:fromTaskId => dep.prerequisite_id.to_s, :toTaskId => dep.task_id.to_s, :color => '4567aa', :thickness => '2', :fromTaskConnectStart => '0', :toTaskConnectStart => '1')
      end
    end
  }

  xml.trendlines{
    xml.line(:start => Time.now.strftime("%d/%m/%Y"), :displayValue => 'Today', :color => '333333', :thickness => '2', :dashed => '1')
  }
}
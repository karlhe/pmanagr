xml.chart(:dateFormat => 'dd/mm/yyyy', :outputDateFormat => 'ddds mns yy', :ganttWidthPercent => '65', :canvasBorderColor => '999999', :canvasBorderThickness => '0', :gridBorderColor => '4567aa', :gridBorderAlpha => '20', :ganttPaneDuration => '3', :ganttPaneDurationUnit => 'm'){
  xml.categories(:bgColor => '009999'){
    xml.category(:start => '1/11/2009', :end => '31/12/2009', :label => 'Residential Construction', :fontColor => 'ffffff', :fontSize => '16')
  }
  xml.categories(:bgColor => '4567aa', :fontColor => 'ff0000'){
    xml.category(:start => '1/11/2009', :end => '31/12/2009', :label => 'Months', :fontColor => 'ffffff', :fontSize => '16')
  }
  xml.categories(:bgColor=>'ffffff', :fontColor=>'1288dd', :fontSize=>'10', :isBold=>'1', :align=>'center'){
    xml.category(:start=>'1/11/2009', :end=>'30/11/2009', :label=>'November')
    xml.category(:start=>'1/12/2009', :end=>'31/12/2009', :label=>'December')
    xml.category(:start=>'1/1/2010', :end=>'31/1/2010', :label=>'January')
    xml.category(:start=>'1/2/2010', :end=>'28/2/2010', :label=>'February')
    xml.category(:start=>'1/3/2010', :end=>'31/3/2010', :label=>'March')
    xml.category(:start=>'1/4/2010', :end=>'30/4/2010', :label=>'April')
  }
  xml.processes(:headerText=>'Task', :fontColor=>'000000', :fontSize=>'11', :isAnimated=>'1', :bgColor=>'4567aa', :headerVAlign=>'bottom', :headerAlign=>'left', :headerbgColor=>'4567aa', :headerFontColor=>'ffffff', :headerFontSize=>'16', :align=>'left', :isBold=>'1', :bgAlpha=>'25') {
    for task in @tasks
      xml.process(:label => task.name, :id => task.id)
      for assignment in task.assignments
          xml.process(:label => "-" + assignment.name, :id => task.id.to_s + "-" + assignment.id.to_s)
      end
    end
  }
  xml.dataTable(:showProcessName => '1', :nameAlign => 'left', :fontColor => '000000', :fontSize => '10', :vAlign => 'right', :align => 'center', :headerVAlign => 'bottom', :headerAlign => 'left', :headerbgColor => '4567aa', :headerFontColor => 'ffffff', :headerFontSize => '16'){
    xml.dataColumn(:bgColor=>'eeeeee', :headerText=>'Start'){
      for task in @tasks
        xml.text(:label => task.start_time.strftime("%m/%d/%Y"))
        for assignment in task.assignments
          xml.text(:label => assignment.start_time.strftime("%m/%d/%Y"))
        end
      end
    }
    xml.dataColumn(:bgColor=>'eeeeee', :headerText=>'Finish'){
      for task in @tasks
        xml.text(:label => task.due_by.strftime("%m/%d/%Y"))
        for assignment in task.assignments
          xml.text(:label => assignment.due_by.strftime("%m/%d/%Y"))
        end
      end
    }
  }
  xml.tasks{
    for task in @tasks
      xml.task(:label => task.name, :processId=> task.id, :start=> task.start_time.strftime("%d/%m/%Y"), :end=> task.due_by.strftime("%d/%m/%Y"), :id=>task.id, :color=>'6B8E23', :height=>'20%', :showAsGroup =>'1')
      for assignment in task.assignments
        xml.task(:label => assignment.name, :processId=>task.id.to_s + "-" + assignment.id.to_s, :start=> assignment.start_time.strftime("%d/%m/%Y"), :end=> assignment.due_by.strftime("%d/%m/%Y"), :id=>task.id.to_s + "-" + assignment.id.to_s, :color=>'4567aa', :height=>'50%')
      end
    end
  }
}
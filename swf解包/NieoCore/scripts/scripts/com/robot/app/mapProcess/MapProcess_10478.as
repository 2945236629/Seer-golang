package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1970;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_10478 extends BaseMapProcess
   {
      
      public function MapProcess_10478()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_ 1970_1",true]);
         mod3 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1970_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3],function():void
         {
            TaskController_1970.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


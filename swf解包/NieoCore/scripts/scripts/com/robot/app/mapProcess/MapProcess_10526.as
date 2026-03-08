package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3005;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   
   public class MapProcess_10526 extends BaseMapProcess
   {
      
      public function MapProcess_10526()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         this.Node1();
      }
      
      public function Node1() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_3005_1"),this.Node2);
      }
      
      public function Node2() : void
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         TaskDiaLogManager.single.playStory([_loc1_],this.Node3);
      }
      
      public function Node3() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_3005_2"),this.Node4);
      }
      
      public function Node4() : void
      {
         var mod:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         TaskDiaLogManager.single.playStory([mod],function():void
         {
            TaskController_3005.completeNode4();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


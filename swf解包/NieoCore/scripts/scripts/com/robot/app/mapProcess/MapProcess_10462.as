package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1960;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10462 extends BaseMapProcess
   {
      
      public function MapProcess_10462()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:uint = 0;
         super.init();
         KTool.showMapAllPlayerAndMonster();
         this.taskMC.visible = false;
         _loc1_ = 1;
         while(_loc1_ <= 3)
         {
            (MapManager.currentMap.controlLevel["btn" + _loc1_] as MovieClip).buttonMode = true;
            (MapManager.currentMap.controlLevel["btn" + _loc1_] as MovieClip).addEventListener(MouseEvent.CLICK,this.onClickHandler);
            _loc1_++;
         }
      }
      
      protected function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:uint = Math.random() > 0.5 ? 4 : 5;
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,5,"mc5"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1960_1",true]);
         var _loc6_:Array = [_loc3_,_loc4_,_loc5_];
         var _loc7_:TaskMod = _loc6_[Math.round(Math.random() * 2)];
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["这难道是真的吗？我不相信！我不相信！  "],["快去和船长汇报！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1960_2",true]);
         this.taskMC.visible = true;
         KTool.hideMapAllPlayerAndMonster();
         var _loc10_:uint = 1;
         while(_loc10_ <= 3)
         {
            (MapManager.currentMap.controlLevel["label" + _loc10_] as MovieClip).visible = false;
            _loc10_++;
         }
         TaskDiaLogManager.single.playStory([_loc7_],this.playEndHandler);
      }
      
      protected function playEndHandler() : void
      {
         var mod4:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["这难道是真的吗？我不相信！我不相信！  "],["快去和船长汇报！"]);
         var mod5:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1960_2",true]);
         TaskDiaLogManager.single.destroy();
         this.taskMC.visible = false;
         TaskDiaLogManager.single.playStory([mod4,mod5],function():void
         {
            TaskController_1960.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10315 extends BaseMapProcess
   {
      
      public function MapProcess_10315()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         (conLevel as MovieClip).buttonMode = true;
         conLevel.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
      }
      
      protected function get storyLineList() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[conLevel,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["赛小息！让你不小心！闯祸了吧！"],["我也不是故意的……"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["现在可怎么办啊，那些赤西西比好像情况更糟了！"],["赶紧想想办法！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[conLevel,2,"mc2"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["这些赤西西比的脾气越来越暴躁了，我们得想办法让他们先平静下来。"],["能用什么办法呢？"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["看来只能以暴制暴了，看我的斩月双刀！"],["阿铁打，你别冲动。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["我们只要把火神之元拿回来就可以了，不要伤到这些赤西西比！"],["放心，我知道的。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[conLevel,3,"mc3"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_];
      }
      
      protected function onMouseClickHandler(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         conLevel.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         TaskDiaLogManager.single.playStory(this.storyLineList,function():void
         {
            (conLevel as MovieClip).buttonMode = true;
            conLevel.addEventListener(MouseEvent.CLICK,sayEndHandler);
            BufferRecordManager.setMyState(697,true);
         });
      }
      
      protected function sayEndHandler(param1:MouseEvent) : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.sayEndHandler);
         (conLevel as MovieClip).buttonMode = false;
         TaskDiaLogManager.single.playStory([new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["赛小息！让你不小心！闯祸了吧！"],["我也不是故意的……"])],this.endStoryHandler);
      }
      
      private function endStoryHandler() : void
      {
         KTool.showMapAllPlayerAndMonster();
         MapManager.changeMap(17);
      }
   }
}


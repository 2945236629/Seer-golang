package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1826;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10376 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10376()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1826.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["这里是天马一族的禁地，传说中天马一族的皇者——黄金天马就沉睡在这里。"],["黄金天马？"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["弗罗多，召唤出黄金天马真的可以带领我们穿越迷宫回到第六星系吗？"],["相信天马一族的能力！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["黄金天马拥有天马一族最纯正的血脉，他超凡的方向感和飞行能力肯定会有所帮助！"],["嗯，那我们试试吧！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["弗罗多，你的召唤术好像不太顺利，黄金天马好像不太愿意听从我们的召唤。"],["他的脾气和实力好像超出了我的预估。"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["也许是因为黄金天马沉睡得太久了，我们需要更加强大的力量来唤醒他！"],["我们一起来帮你！"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["我们需要你带领我们回到第六星系，你之前去过第六星系，我记得创世之神曾经给你的翅膀加过祝福。"],["创世之神？让我好好想想……"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["好像确实是这样，他可是我们天马一族进化的大恩人，你们身上怎么会有他的气息，我记得他的手下是神域四天王啊？"],["我们是创世神兵。"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["我们是创世之神的武器幻化成的精灵，现在我们需要你的帮助！"],["恩，既然这样，那好吧。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HUANGJINTIANMA,["不过原谅我年纪大了，这么多年过去，我可能不记得第六星系的位置了，哈哈……"],["老马识途，你一定可以的！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         this._taskMC = null;
         super.destroy();
      }
   }
}


package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1777;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10354 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10354()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1777.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["创造逆界之门果然是一个错误，如果不毁掉它，还会有源源不断的危险！"],["确实隐藏着无数的危险。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["只有一个伊兰迪现身，不知道其他人有没有重生，我们要赶紧去阻止索伦森！"],["应该没有那么快吧！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["圣翼之灵，为什么索伦森在寻找你们，他的目的是什么？"],["我想，应该和创世之神有关。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["我们继承了创世之神的力量，他应该是在觊觎这个，至于用这个力量干什么，我就不清楚了。"],["肯定不会是什么好事。"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["不过索伦森一定不会看着我们摧毁逆界之门，如果他出手阻挠就麻烦了……"],["放心，还有我们！"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["我们会帮助你牵制索伦森，即使暗黑战神联盟出现，我们也有信心拖住他们！"],["这场战斗会非常凶险……"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["我相信你们，只要创造出时机，我一定可以摧毁逆界之门！"],["我们一定可以的！"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["伙伴们，我们走吧！战斗的时候到了！"],["我们早就准备好了！"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._taskMC = null;
      }
   }
}


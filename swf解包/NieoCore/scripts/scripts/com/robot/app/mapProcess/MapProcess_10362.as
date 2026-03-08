package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1795;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10362 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10362()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1795.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["站长，据索伦森说的，第六星系就在那片星云后面，不过现在被强大的力量封锁住了！"],["恩，确实是非常强大的力量。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["一定是这股力量把探测雷达的信号也吸收了，所以我们一直没有发现。"],["站长，我们能过去吗？"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["这个结界似乎非常强大，连索伦森和圣翼之灵也闯不进去！"],["是吗？我来试试看。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["赛尔们，这个结界非常危险，你们不要轻易触碰。"],["那怎么才能冲破这个结界呢？"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["这是我们第六星系自己的恩怨，你们不需要插手！"],["我们只是想帮助你们……"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["我们赛尔是正义和和平的象征，我们探索宇宙不仅绝不会给你们带来危险，相反还可以用科技帮助你们！"],["谢谢了，不过还是先打破结界再说。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task1795_1",true]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["看来光凭我们两个的力量还不够，是不是应该去找其他人了？"],["结界的力量似乎刚刚又加强了……"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["为什么我感觉那几个黑影的气息非常熟悉，我们走了之后第六星系到底发生了什么？"],["这也是我想知道的。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["两位，也许我们赛尔可以帮助你们回到第六星系！"],["多谢你的好意。"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["但是我们现在只能相信自己，正如黑影说的，外人的进入也许会给第六星系带来动乱……"],["我们赛尔只会带来正义与和平！"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task1795_2"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_];
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


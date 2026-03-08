package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1750;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.StoryLoaderManager;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10346 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10346()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10346_0";
         StoryLoaderManager.insatnce.setloaderHandler = this.getStoryMCHanlder;
      }
      
      public function get taskMC() : MovieClip
      {
         return this._taskMC;
      }
      
      private function getStoryMCHanlder(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         this._taskMC = mc;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1750.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["雷伊，这是邪恶的力量，快把翅膀收回去，不然你会慢慢被这股力量侵蚀堕落的！"],["我知道，可是……"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["这股力量太强大了，它在试图驾驭我，我无法控制它！"],["怎么会这样？"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["索伦森太恶毒了，这样下去雷伊终会被邪恶力量控制住的！"],["那怎么行，雷伊可是正义的象征！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["对不起，盖亚，刚刚我无法控制自己……"],["雷伊，不怪你，我明白。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["必须彻底清除掉这股邪恶的力量，不然雷伊的状态会这样一直不稳定，实在太危险了！"],["应该怎么清除呢？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["只要能去掉这个邪恶的翅膀，即使失去雷光之翼我也在所不惜，我实在不能忍受这股邪恶的力量停留我身上一秒！"],["我们会帮你的雷神！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JIMILIYA_SPUER,["月光之神赐予的他无坚不摧的双刀，锋利地足以切开一切！"],["看来能派上用场！"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["太好了，就用你的破月之刃帮我切下这对邪恶的翅膀吧！"],["雷神，不能这样！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["雷伊，这样的后果无法估量，说不定你会失去雷光之翼！要三思啊！"],["我已经考虑清楚了！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["太好了！那对邪恶的翅膀消失了！"],["恐怕没这么简单。"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["谢谢你，我感觉好多了。"],["雷伊，那你的雷光之翼呢？"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["我感受咒符的力量还在，无法生出雷光之翼……不过没有了那对黑色的翅膀，我感觉已经好多了。"],["怎么会这样……"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,5,"mc5"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_];
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._taskMC = null;
      }
   }
}


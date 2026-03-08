package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1734;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.StoryLoaderManager;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10345 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10345()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10345_0";
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
            TaskController_1734.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["索伦森给雷伊种下了暗黑的符咒，他的雷光之翼的已经不见了，只有这个黑色的翅膀！"],["这个翅膀太诡异了！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["这黑色的翅膀充满的邪恶的力量，这根本不属于雷伊！索伦森是想通过它控制雷伊吗？"],["看来是这样。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["这股邪恶的力量在雷伊体内十分不稳定，如果控制不好，可能雷伊就会永远失去雷光之翼，甚至心志也会被动摇！"],["这么严重？"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["看来只有帮雷伊找回雷光之翼才能压制住这股力量。"],["可是黑色翅膀的力量太强了。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JIMILIYA_SPUER,["恩，盖亚，我们一起帮助雷伊，重现雷光之翼！"],["恩，我相信雷伊一定会回来"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["盖亚，看来超进化的力量果然不是谁都能控制的，恭喜你了！以后战神联盟的荣耀只能靠你了……"],["你在说什么呢雷伊！"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["雷伊，我们战神联盟是一个集体，你也是其中一员，放心，我们一定会帮助你的！"],["谢谢你，伙伴！"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["可是我感觉雷光之翼已经离我越来越远，我无法控制住这股能量……有时候我甚至无法控制住我自己……"],["你可以的雷伊！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["别忘了，我们可是一生的对手，只有你雷伊才配与我盖亚交手，我还期待着与你的第三次对决，这次可是超进化对决！"],["超进化对决？我不会忘的。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["1734_2",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_];
      }
   }
}


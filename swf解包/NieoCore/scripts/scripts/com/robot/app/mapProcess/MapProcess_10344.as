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
   
   public class MapProcess_10344 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10344()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10344_0";
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
            TaskController_1734.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["是啊，我还真想念我的奴仆们，可惜时空撕裂的能量太巨大了，只能找回他们的精元，还需要一段时间才能重生了。"],["你居然想复活他们？"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["怎么？你感觉势单力薄了？又需要那群帮凶了？"],["哈哈，天真的想法。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["身为至高无上的暗黑魔君，总不能凡事都亲力亲为吧，我需要这群忠诚而且足够强大的奴仆。"],["我不会让你得逞的！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["看来你还没有领教过我的实力，难怪这么狂妄，不过我非常欣赏你的天赋，不如为我效力怎样？"],["真是异想天开！"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["我可不是伊兰迪！记住，我是雷伊！"],["我会赐予你无与伦比的力量！"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["难道你忘了被伊兰迪击败的羞辱吗？相信我，我会把你打造成为最强者，所有的凡域精灵都会拜倒在你脚下！"],["这并不是我要的。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["1734_1",true]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["从此以后，什么盖亚，谱尼都不会是你的对手了！"],["太好了，这正是我想要的。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["我会成为战神联盟最强，哦不，宇宙最强的精灵！谢谢你主人！"],["这样才对嘛。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["只要你效忠于我，你还可以得到更多！"],["我会效忠你的，主人！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["玛法里奥，这只精灵的天赋让我想起了年轻时的你，现在他落在我的手里，真是如虎添翼！"],["你想控制他帮你作恶？"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FAMALIAO,["看来是索伦森的力量控制了他的心志，还好我们来得及时，邪恶的来源一定就是那对黑色的翅膀！"],["这个不是雷光之翼！"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JIMILIYA_SPUER,["雷神绝不会就这样堕落的，看我替他剪掉这对邪恶的翅膀！"],["哈哈，想得太简单了。"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_];
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}


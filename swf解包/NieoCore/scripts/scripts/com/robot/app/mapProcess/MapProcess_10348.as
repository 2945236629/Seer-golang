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
   
   public class MapProcess_10348 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10348()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10348_0";
         StoryLoaderManager.insatnce.setloaderHandler = this.getStoryMCHanlder;
      }
      
      private function getStoryMCHanlder(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         this._taskMC = mc;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1750.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["圣翼之灵？难道是传说中的创世六神兵？"],["你是谁？竟然会知道创世六神兵？"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["为什么你身上会有不属于这个时代的气息，感觉似曾相识……"],["哈哈，我确实不属于这个时代。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["因为我是刚从一万年前复生的老家伙了，其他五位创世神兵呢？"],["他们已经不知下落了……"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["玛法里奥，什么是创世神兵的传说？"],["那是一个可以追溯到这个世界尽头的传说……"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.CARTOON,0,null,null,["cartoon/cartoon_20130912"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["自创世之神死后，创世六神兵一直在等待他们新的主人，带领他们去完成一项伟大的使命……"],["不愧是玛法里奥，知道这么多。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["确实是这样，这次魔域再次出现，我感觉到我们等待的使命终于要来了……"],["只是创世之神已经不在了……"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["还有谁能有这样强大的力量可以驾驭创世六神兵呢？"],["命运中总会有那个注定的人出现。"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["对了，我上次看到索伦森正在准备复活暗黑战神联盟。我们要赶快阻止他！"],["千万不能让他们重生！"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["索伦森一定会去逆界之门，只有那里才能借助魔域的力量，暗黑战神联盟才有希望重生。"],["我们快去阻止他！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["千万不能误会，我相信你是我们的朋友，我们只是想了解我们共同的敌人！"],["好吧，那已经是很久以前的事情了。"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["其实我和谱尼还有麒麟当年都是好朋友，就和现在你们四个一样，用一个恰当的比喻，就好比一万年前的战神联盟。"],["一万年前的战神联盟？！"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["这个比喻真有意思，你们确实也都是宇宙中的强者。"],["对，确实是因为这样。"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["我们三个是当时宇宙中最具天赋的精灵，四处对抗邪恶，大家把我们称为上古三杰！"],["什么上古三杰？"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1750_2",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_];
      }
      
      private function get taskMC() : MovieClip
      {
         return this._taskMC;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._taskMC = null;
      }
   }
}


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
   
   public class MapProcess_10343 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10343()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10343_0";
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
            TaskController_1734.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["我不是艾辛格，我是盖亚！你是谁？"],["不要狡辩，你不是盖亚！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KELEIAO,["我是来自赛伯坦星的战士科雷傲，代表我的故乡对抗暗黑魔君，我追击你们暗黑战神联盟已经很久了！"],["原来是这样。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["这么说我们是朋友，很高兴与你并肩作战！"],["还想欺骗我吗？"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KELEIAO,["战神盖亚可不是你这个样子的，难道你害怕与我科雷傲一战吗？艾辛格！"],["真是个不讲道理的家伙！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KELEIAO,["可是真的盖亚不是这个样子的，为什么看起来不一样？"],["那是因为盖亚超进化了。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI,["超进化的盖亚拥有了更强的力量，形象也产生了一些变化，不过他可不是艾辛格！"],["原来是这样。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KELEIAO,["是我一时糊涂了，误以为是艾辛格，真是抱歉！"],["没有关系，不打不相识。"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_WHITE,["上次的惨败真是我们战神联盟的耻辱，不过幸好现在我们有了超进化的盖亚，一定可以重振雄风！"],["恩，我也相信盖亚！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KELEIAO,["刚才和盖亚的交手真是获益匪浅，宇宙间还有这样的强者，看来以前我多少是有些自大了。"],["科雷傲你太谦虚了。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["伙伴们，放心吧，我们战神联盟从此以后一定会战无不胜，绝不会再犯同样的错误！"],["说得对盖亚！"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_];
      }
   }
}


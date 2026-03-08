package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1764;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.StoryLoaderManager;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10351 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10351()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10351_0";
         StoryLoaderManager.insatnce.setloaderHandler = this.getStoryMCHanlder;
      }
      
      private function getStoryMCHanlder(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         this._taskMC = mc;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1764.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["哟！各位手下败将，好久不见了！"],["你说谁是手下败将！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PAXIUSI,["刚刚只是被你外表欺骗，被你偷袭了，我们来再战一场！"],["真会给自己找理由。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["再战一百场也是一样，弱者就是弱者，改变不了什么。"],["不要太嚣张！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["原来已经觉醒了一个，是我的主人在找你，乖乖跟我回去吧！"],["你开什么玩笑。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["索伦森为什么要找创世六神兵？他到底有什么阴谋？"],["你们好奇心还真强。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["难道你们还不明白，主人想征服凡域易如反掌，他真正感兴趣的是隐没在凡域的创世六神兵！"],["他要创世神兵干什么？"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["创世神兵是创世之神留下的武器，威力无比，有了它主人才能对抗神域，只有神域才是主人的目标，明白了吗？"],["神域？波斯蒂加的世界？"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["我们要尽快阻止索伦森了，如果让他拿到了创世六神兵，就真的无法阻挡了！"],["恩，我们尽快去吧！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["索伦森一定在逆界之门，只有那里才能借助魔域的力量，暗黑战神联盟才有希望重生。"],["那我们就再闯逆界之门！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["只看到了伊兰迪，希望暗黑战神联盟还没有完全重生！"],["应该没有这么快。"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["逆界之门的存在始终是个祸害，这次我们就一起关闭它吧！"],["它早就应该被摧毁了。"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1764_2",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_];
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


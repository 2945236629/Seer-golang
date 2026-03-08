package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1713;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10341 extends BaseMapProcess
   {
      
      public function MapProcess_10341()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override protected function init() : void
      {
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.storyLine,function():void
         {
            TaskController_1713.completeNode4();
         });
      }
      
      protected function get storyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["你休想破坏我们的世界！"],["这个世界已经属于我了。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["你以为躲到这里就可以了吗？暗黑战神联盟已经为你献祭了，你现在孤掌难鸣！"],["他们？难道你以为我只有他们！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["魔域的力量不是你可以揣测的，暗黑战神联盟只是其中小小的一部分，凡域之门已经打开，你们是不能阻止我的！"],["你不要太自信了！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["这里毕竟是凡域，我不相信你能完全施展你的实力。"],["那你就错了，波斯蒂加！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["不好，这是魔域的气息，这个地方太邪恶了，赶紧走！"],["有这么夸张？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["我和战神联盟的力量都还没完全恢复，这里实在不适合大战！"],["难道就这样放过索伦森？"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["哈哈哈哈，今天让你们知道，有些地方不是你们想来就能来的！"],["这个地方太危险了……"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1713_2",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_];
      }
      
      private function get taskMc() : MovieClip
      {
         return conLevel["taskMc"];
      }
      
      override public function setup() : void
      {
         super.setup();
      }
   }
}


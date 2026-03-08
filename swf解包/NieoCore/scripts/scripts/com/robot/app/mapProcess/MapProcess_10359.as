package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1792;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10359 extends BaseMapProcess
   {
      
      public function MapProcess_10359()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1792.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["根据我们之前的探查只是发现了五个星系，第六星系在哪里？"],["在第五星系的边缘。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["索伦森和圣翼之灵都是来自第六星系，但是现在入口被一个强大的结界封锁了，所以探测不到。"],["还有这种事情？"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["如果这是真的，那将是赛尔号探险宇宙的一大重要发现！"],["船长，我们都准备好了。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1778_1",true]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["现在看来螺旋星系的边缘有可能确实存在一个新的星系，而且是一个完全未知的世界。"],["罗杰船长，你确定吗？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DOCTOR,["这个发现确实非常重要，不过还有待证实。"],["恩，我们必须先证实它的存在。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["而且据说那里还有一个非常强大的结界无法靠近，我们一定要谨慎！"],["我们赛尔一定可以征服挑战！"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1778_2",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}


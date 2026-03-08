package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1839;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10387 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10387()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1839.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["就是这里了。五峰山崖，远处的瀑布是试炼圣盾的最佳场所。"],["希望他愿意和我们一起走！"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["罗慕洛拥有世间最好的盾，如果他与我们一起，我们便有强大的防御能力。到时候不管谁的阻拦，我们都无所畏惧。"],["我们先找一找吧！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["大家小心！我感觉似乎有点不对劲！"],["大家小心！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZENISEN,["行不更名，坐不改姓。我就是泽……我就是罗慕洛！"],["你的盾呢？"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZENISEN,["盾？什么盾？我从来不用盾！我赤手空拳就能打败老虎！"],["真是有意思！"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LUOMULUO,["竟然有人敢冒充创世神兵。说出你背后的主谋是谁吧？"],["可恶！"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LUOMULUO,["还是被他跑了！你们进来吧。这里是天然的屏障，外界根本无法攻击这里。我们在这里商量下一步吧！ "],["你是罗慕洛？"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["那刚才的那个人为什么要冒充你？"],["我想可能跟赫尔墨斯有关！"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1839_2"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
   }
}


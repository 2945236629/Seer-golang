package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3031;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10554 extends BaseMapProcess
   {
      
      public function MapProcess_10554()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod4:TaskMod;
         var mod5:TaskMod;
         var mod6:TaskMod;
         var mod7:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3031_1",true]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["卡小修……你……"],["大个子！你说不会离开我的！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_YOUNG,["我不要！你骗我！"],["听话，不可以胡闹，正义不会败给邪恶。"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_YOUNG,["不要，我也要跟你一起战斗。"],["你把眼睛闭起来，替我许一个愿望。"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_YOUNG,["好，不许骗我。"],["对不起……"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod7 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3031_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7],function():void
         {
            TaskController_3031.completeNode4();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


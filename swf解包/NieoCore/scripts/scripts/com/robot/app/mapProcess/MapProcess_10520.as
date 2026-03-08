package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3003;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10520 extends BaseMapProcess
   {
      
      public function MapProcess_10520()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["还轮不到你教训我！与我合作，我会帮助你彻底摧毁克罗诺斯。但是你别忘了我们的征程。"],["你要想到最后的结局！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSAIDONG,["很有可能，你的结局就是众叛亲离！你为了你的复兴大业，反而付出了更多！"],["闭嘴！"]);
         mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod5 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3003_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5],function():void
         {
            TaskController_3003.completeNode4();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


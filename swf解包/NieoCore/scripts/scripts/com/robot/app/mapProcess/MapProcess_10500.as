package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1992;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10500 extends BaseMapProcess
   {
      
      public function MapProcess_10500()
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
         var mod8:TaskMod;
         super.init();
         if(TasksManager.getTaskStatus(1992) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1992);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["我以为史莱姆国王多强大！没想到……不堪一击呀！"],["我绝对不会惧怕你！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHILAIMU_KING,["因为我刚刚复活，能力根本没有恢复！否则，我肯定直接消灭你！"],["吹牛吧！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["我随时等你来消灭我！不过，今天我要带走永恒石！"],["你休想！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["又来一个！那就和史莱姆国王一起消失在永恒树吧！永恒石，我今天要定了！"],["你休想！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHILAIMU_KING,["我会用生命守卫永恒石的！它只属于大地之神！"],["那只好硬抢了！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1992.completeNode1();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


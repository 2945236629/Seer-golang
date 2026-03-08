package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10515 extends BaseMapProcess
   {
      
      private static const PRE_TASK_BUF:int = 1143;
      
      public function MapProcess_10515()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod4:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["我们快去追击战神联盟！找到缪斯！不能让他们破坏我们的计划！" + "魔石不能够被他们获得！"],["我们走！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA_EVO,[MainManager.actorInfo.formatNick + "，我要阻止魔灵王找到缪斯。但是，妖石山一定藏有他们的魔石。你一定要找到，并且立即销毁。"],["我明白了！"]);
         mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4],function():void
         {
            KTool.showMapAllPlayerAndMonster();
            BufferRecordManager.setMyState(PRE_TASK_BUF,true);
            MapManager.changeMap(990);
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


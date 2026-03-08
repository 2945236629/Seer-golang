package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1987;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10495 extends BaseMapProcess
   {
      
      public function MapProcess_10495()
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
         var mod9:TaskMod;
         var mod10:TaskMod;
         var mod11:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["克罗诺斯！多行不义的家伙，你快点离开这里！否则，卡修斯一定会让你输得很惨！"],["让我输？哈哈哈！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KULUOLUOSI,["我还从来没有尝过“输”是什么滋味！"],["可恶的家伙！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["今天就让你尝尝什么叫做彻底的失败！米咔，上吧！击败他！"],["米咔米咔！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1987_0",true]);
         mod7 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["卡修斯！宙斯！你们怎么样？"],["没想到他们两个终究还是联合在一起了！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZHOUSI,["现在只有使卡修斯成功封神，进化成为大地之神，才能够抵挡魔灵王与克罗诺斯的攻击！"],["我们该怎么办？"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZHOUSI,["想要成为大地之神，必须得到地祇石的能量！" + MainManager.actorInfo.formatNick + "，你能够帮助卡修斯找到吗？"],["没问题！我一定可以！"]);
         mod11 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,4,"mc4"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_1987.completeNode2();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


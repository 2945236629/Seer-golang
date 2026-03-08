package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1992;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10502 extends BaseMapProcess
   {
      
      public function MapProcess_10502()
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
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["主人息怒！主人！请饶恕我吧！下次……下次我一定会完成任务的！"],["下次？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["卡修斯得到永恒石，就能够顺利的超进化！成为真正的大地之神！到时候，谁还能够阻挡他？"],["难道我们彻底输了？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["主人，以你的实力也不足以与卡修斯对抗吗？"],["我的实力？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["主人，他是……"],["该怎么介绍呢？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["就是一个能够彻底瓦解战神联盟的家伙！是吧？"],["战神联盟？哼！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["魔灵王！记住我们达成的协议！"],["哈哈！"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["你只要彻底瓦解战神联盟，让我得到我想要的东西，整个魔灵星都归你！"],["我只要我说的！"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["战神联盟！该从谁开始呢？那就从我亲爱的妹妹吧！缪斯——灭亡吧！"],["好强大的能量！"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_1992.completeNode3();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


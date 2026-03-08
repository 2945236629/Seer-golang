package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3005;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10523 extends BaseMapProcess
   {
      
      public function MapProcess_10523()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["就是他！我们都被他骗了！他的真实身份是上古十大凶兽——摩哥斯！"],["摩哥斯？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["看来魔灵王势必要将泰坦星系搅得天翻地覆了！竟然将上古十大凶兽召唤出来！缪斯，接下来，我们要处处小心他的攻击！"],["停！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["先说你！你到底是谁？你为什么和我哥哥长得如此相像？"],["你还是不要知道的好！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["你为什么会耶里梅斯的神技？你和哥哥到底说没关系？你知不知道他在那里？"],["我说了，你还是不要知道！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["你的伙伴还在暗夜城经受魔灵王的攻击！如果你还想见到他们，你就跟我赶快回去救援！"],["对！战神联盟！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["是的！缪斯，快去救援战神联盟！魔灵王的实力，不容小觑！而且很有可能…摩哥斯已经前去帮助魔灵王了！"],["事不宜迟！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_3005.completeNode1();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


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
   
   public class MapProcess_10519 extends BaseMapProcess
   {
      
      public function MapProcess_10519()
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
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["阿萨斯得到魔石的能量，实力大增。如今已经丧失了理智了！你们快走！"],["你到底是谁？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["为什么你说话的语气与我哥哥如此的像！你和天蛇星到底有什么渊源？"],["呵？兄妹相认？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["真可惜！刚刚相认就要一起在这里灭亡了！让我来消灭你们吧！"],["你…你怎么会？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["哈哈哈！我的好侄儿！没想到你还没有离开棱石星！"],["闭嘴！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BULAIKE_NEW,["我一分钟都不想留在棱石星！但是，也请你把狂妄的野心收回去！不要再做无谓的伤害了！"],["哈哈！你觉得可能吗？"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_3003.completeNode3();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


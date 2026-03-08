package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3031;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10551 extends BaseMapProcess
   {
      
      public function MapProcess_10551()
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
         super.init();
         if(TasksManager.getTaskStatus(3031) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(3031);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["真是费了一番功夫才找到你们！累死老子了。"],["你是谁？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["我劝你速度离开，不要打扰到这里的安宁！"],["呸！安宁？信不信我让这里瞬间化为灰烬？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["告诉你，我可是妖王摩哥斯！你给我听清楚了，以后宇宙就是我们魔界的后花园！"],["妖王摩哥斯……从来没听说过。"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["你是要让我动手吗？来自魔界的朋友？"],["这里还有你动手的机会？！不过我手下从来不斩无名之人！"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOGESI_YAOMO,["不过你长得和大地之神有几分相似，难道是大地之神变异了？哈哈哈哈！"],["住嘴！你个丑八怪！"]);
         mod7 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["卡小修！你没事吧！"],["唔……好疼啊……"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_YOUNG,["好疼啊……大个子……我什么时候才能有真正的力量？"],["你……一定会有！"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["我会一直在你身边，卡小修。"],["我相信你。"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            TaskController_3031.completeNode1();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


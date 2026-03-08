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
   
   public class MapProcess_10553 extends BaseMapProcess
   {
      
      public function MapProcess_10553()
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
         mod1 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3031_0",true]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["魔界之人当真要不死不休的追杀吗？"],["不不，我从不杀戮，那是莽夫的行为。"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["杀戮这种东西我很唾弃，你要相信我，我这次来，是有礼物要送给你们的。"],["礼物！我想要的！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_YOUNG,["是什么礼物啊？？？能给我看看吗？"],["卡小修！不要搭理他，他是个疯子！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["你到底是谁？我们不要你的礼物，请你离开！"],["哈哈哈！既然来了！你们怎么能不给我炼狱魔神面子呢！"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["我还是那个问题，你，为何要成魔！"],["你知道魔界之门是如何裂开的吗？"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["我希望你可以记住一个精灵，他叫伊洛维奇。是他毁灭了自己震碎了魔界之门。"],["他为什么要这么做？"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["他为了自己的使命，入了魔。那种入魔后的力量，让他足以毁灭宇宙。"],["一定要如此吗，一定最终要这样才能实现吗？"]);
         mod10 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DADIZHANJIA,["这样毁灭了自己，重创一切，真的是他想要的吗？"],["大地战甲，你还不明白这种无可奈何吗？"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["这种无可奈何，来源于我们终究所要面临的对决，禁魔之崖的那场雨，就是你最后的眼泪。"],["我明白了。"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11],function():void
         {
            TaskController_3031.completeNode3();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


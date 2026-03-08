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
   
   public class MapProcess_10524 extends BaseMapProcess
   {
      
      public function MapProcess_10524()
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
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["布莱克！别白费力气了！你的所有技能都是我教的！你不可能是我的对手！"],["可恶！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BULAIKE_NEW,["我再奉劝你一次！收起你的野心！邪不胜正，你终究还是会失败的！"],["哦？是吗？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["弱肉强食！一切都是用实力说话！我从小就教你这些，你怎么都忘了？"],["我一定会让你尝到失败的滋味的！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["看来你们还真是有难同当呀！既然这样，我就成全你们！一起把你们葬送在这里！"],["狂妄的家伙！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["你终于暴露出自己的野心了！差使奥罗纳尔逼迫索伦森去挑战神域天王的也是你吧？"],["是又怎么样？"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["所有的一切，都是为了你的野心！为了你称霸泰坦星系！所以你排除索伦森，控制阿萨斯！"],["知道的太迟了吧！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_3005.completeNode2();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


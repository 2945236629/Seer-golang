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
   
   public class MapProcess_10552 extends BaseMapProcess
   {
      
      public function MapProcess_10552()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["你的话真的很多。如果我们不是同为魔神，我势必要解决你。"],["动手？你不一定打的过我！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["为什么你总是要摆出一副高高在上的样子？你是不是真的以为我怕你？"],["你很烦。"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["我烦？好！好！我烦！我就是不明白你为什么要放走敌人，被正义感化了？心中充满爱了？感觉自己堕落了？"],["……"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["这件事情你不要再插手了！我要让那些所谓正义的人尝一下被折磨的滋味！哈哈！灵魂从身体中被我剥离！"],["去吧。"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["祝你好运，毁灭魔神和寂灭魔神那边事情处理的如何？"],["已经征服了大半个宇宙，大地战甲他们应该还在怀特星吧？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["等我找到了他们，哈哈哈哈，我一定要好好的折磨他们几天几夜，直到那些破铜烂铁都在炼狱之中灰飞烟灭！"],["我希望你活着回来。"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7],function():void
         {
            TaskController_3031.completeNode2();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}


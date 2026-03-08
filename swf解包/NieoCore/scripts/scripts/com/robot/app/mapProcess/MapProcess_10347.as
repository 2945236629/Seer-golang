package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1750;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.StoryLoaderManager;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10347 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10347()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10347_0";
         StoryLoaderManager.insatnce.setloaderHandler = this.getStoryMCHanlder;
      }
      
      private function getStoryMCHanlder(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         this._taskMC = mc;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1750.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PAXIUSI,["我是珀修斯，奉命守护着圣翼之灵，等待着命运中的人来唤醒圣翼之灵。"],["圣翼之灵是什么？"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["我只是无心闯入，圣翼之灵是什么，为什么从来没有听说过？"],["你没有必要知道！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PAXIUSI,["你已经犯下了大错，给你一点教训，免得以后又想来骚扰圣翼之灵！"],["我马上就走不就行了。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["害怕了吗？我也无意伤害你，大不了我走就是了。"],["我才不是害怕。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PAXIUSI,["“一个操控雷电的强者，会在这里唤醒圣翼之灵，找回他失去的东西”，难道你就是传说中那个强者？"],["传说？我从没听说过。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["失去的东西？难道是说我的雷光之翼？"],["看来创世六神兵觉醒的时候到了。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PAXIUSI,["果然是这样，圣翼之灵终于觉醒了！创世六神兵终于要现世了！"],["这家伙看起来很厉害。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["为什么这个金色的精灵身上会有魔域的气息，命运中不应该会是这样的人唤醒我！"],["也许是因为索伦森的符咒……"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["我是雷伊，索伦森的符咒害我失去了雷光之翼，我绝不是来自魔域！"],["索伦森？好熟悉的名字。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1750_1",true]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["谢谢你，圣翼之灵，我感觉身上那股邪恶的力量已经完全消失了！"],["这样就太好了。"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["对了，圣翼之灵，你是怎么知道解除索伦森的咒符的？"],["因为我是创世六神兵之一！"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["传说伟大的创世之神在创造世界之后，将他的武器变成了六个精灵，我就是其中之一，圣翼之灵！"],["创世六神兵？"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["这和索伦森有什么关系呢？索伦森是来自魔域的恶魔！"],["也许因为魔域就是创世之神最大的敌人。"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_];
      }
      
      private function get taskMC() : MovieClip
      {
         return this._taskMC;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._taskMC = null;
      }
   }
}


package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1826;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10378 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10378()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1826.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["明明是你杀死的创世之神？为什么还要怂恿我们去找别人报仇？"],["什么？赫尔墨斯跟你们说了什么？"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["赫尔墨斯，你还是这么奸诈狡猾，明明是你们自己干的好事，为什么要诬赖我？"],["索伦森，你居然不敢承认。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["索伦森，你早就想杀死创世之神称霸第六星系了，我们只可惜没有阻止你的阴谋……但是今天你会付出代价的！"],["想归想，但是我没有做！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["不要狡辩了，就凭你利用我们害得达芙妮受伤，我们也不会放过你！今天来个了结吧！"],["想要趁火打劫就直说，你们一直这么虚伪！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1826_0",true]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HEERMOSI,["只凭你们三个是无法击败索伦森的，不要在这里和地狱修罗浪费时间，其他创世神兵在哪里？"],["我们暂时还没发现。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUXIULUO,["怎么了？害怕了？没想到沉睡这么久，还是碰不到合适的对手，真寂寞啊……"],["……你继续得瑟吧。"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["我们会回来找你算账的，现在不想在你这里浪费时间。"],["真会给自己找借口。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1826_1"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         this._taskMC = null;
         super.destroy();
      }
   }
}


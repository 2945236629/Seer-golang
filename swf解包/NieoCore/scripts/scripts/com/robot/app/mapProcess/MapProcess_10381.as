package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1833;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10381 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10381()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1833.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["主人你的伤势怎么样了？创世神兵他们看起来气势汹汹！"],["还好，我在慢慢地恢复。"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我最担心的情况还是发生了，创世神兵和神域天王联手，这下情况不妙了。"],["主人，我们早晚会与他们一战！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["我早就说过，创世神兵和我们不是一路的，早晚会与我们为敌。"],["但是至少我现在不想这样。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["不过既然赫尔墨斯从第六星系出来了，这也是一个机会，他身上一定有通往第六星系的钥匙！"],["说得对，先打败他们，再杀回第六星系！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["忠实的随从们，我需要大量的能量来疗伤，上次去赛尔号太空站找谱尼的时候，我发现那里似乎储存着足够的能量。"],["主人，你的意思是？"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["索伦森，我跟随你只是为了打败哈克萨斯，称霸龙族，我可并不想和赛尔为敌。"],["真是头脑简单。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["龙王子哈克萨斯是赛尔的朋友，如果太空站被袭击，他一定会去帮忙，到时候你想伏击他，还是趁机攻击龙族，都很简单！"],["哈哈哈，原来是这样！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AIXINGE,["主人，那三个家伙真的靠得住吗？"],["放心吧，我自有安排。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["只需要他们把外面搅得混乱，吸引住创世神兵的注意，让我安心养伤就可以了。"],["原来是这样。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AIXINGE,["可是主人你的伤势不能再拖了，万一这个时候创世神兵找上门来……"],["艾辛格说得对！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["为什么不派我和艾辛格去太空站呢？我们一定给你抢回能量，治好伤势！"],["我这么做都是有原因的。"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AIXINGE,["是什么任务，主人？"],["这个地方实在太危险了。"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我需要一个隐秘的地方疗伤，在此期间，你们只要好好护卫我就可以了！"],["放心吧，主人！"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AIXINGE,["只要主人伤势恢复了，什么创世神兵，神域天王都不会是主人的对手！"],["那是当然！"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
   }
}


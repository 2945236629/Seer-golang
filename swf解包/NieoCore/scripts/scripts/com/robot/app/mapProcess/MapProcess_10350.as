package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1764;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.StoryLoaderManager;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10350 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10350()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         StoryLoaderManager.insatnce.swfName = "map_10350_0";
         StoryLoaderManager.insatnce.setloaderHandler = this.getStoryMCHanlder;
      }
      
      private function getStoryMCHanlder(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         this._taskMC = mc;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1764.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["后来的事情波斯蒂加已经带你们看过了，我实在无法坚持到谱尼和麒麟回来……"],["恩，我们都知道了。"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["后来就是迈迪文和博拉纳兄弟的出现，我还真的很想念他们……"],["我也感觉很亏欠他们。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["我确实因为年轻气盛犯下过错误，但是现在我意识到了后果，我一定会用尽一切弥补！"],["我们相信你，玛法里奥！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["盖亚，你超进化之后力量果然增加了不少，看来你果然是我一生的对手！"],["雷伊，你也是一样。"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["看来你已经彻底恢复了，这才是真正的雷光之翼，我们的雷神终于回来了！"],["我的感觉也好极了。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["你们交手注意分寸啊，千万不要两败俱伤，还有激烈的大战在等待着我们！"],["我们明白！"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PAXIUSI,["刚刚有个叫伊兰迪的精灵偷袭了我，他太像雷伊了，我一时没有防备……"],["伊兰迪？他已经重生了？"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["看来索伦森的动作比我们想象要快，如果暗黑战神联盟全部重生事情就麻烦了……"],["目前只是发现了伊兰迪。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["奇怪，伊兰迪为什么要偷袭你呢？"],["我想和圣翼之灵有关系。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.PAXIUSI,["他好像也在寻找创世六神兵，只可惜他来晚了一步，圣翼之灵已经觉醒了。"],["索伦森为什么要找创世六神兵呢？"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_];
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


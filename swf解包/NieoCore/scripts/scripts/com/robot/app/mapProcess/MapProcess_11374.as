package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import flash.events.MouseEvent;
   
   public class MapProcess_11374 extends BaseMapProcess
   {
      
      public function MapProcess_11374()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["npc"],this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.dialogArr,function():void
         {
            MapManager.changeMapWithCallback(1,function():void
            {
               SocketConnection.send(45693,12,2);
               ModuleManager.showAppModule("ZLWSGetCyanPanel");
            });
         });
      }
      
      private function get dialogArr() : Array
      {
         var _loc4_:TaskMod = null;
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DOCTOR,["你好啊，小赛尔，有什么事情吗？"],["船长室的卫兵让我来找您拿一种饮料，这是他的信。"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DOCTOR,["哦，我知道了。以前他都是自己来的。"],["他现在正在执勤，不方便过来的。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DOCTOR,["也对。好心的小赛尔，他会很感谢你的。给，这是他要的饮料，这种饮料可以很快地恢复战力呢。"],["这是卫兵自己用的吗？我听他的话，他好像想要去参加巅峰联赛。"]);
         _loc4_ = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DOCTOR,["不，这是他最好的朋友要的,只是他的朋友很久没有回来过了，不过他每次去看巅峰圣战，都会给他的朋友带上一瓶药剂。"],["哦，是这样。谢谢你，博士。"]);
         _loc1_.isNewDialog_1 = true;
         _loc2_.isNewDialog_1 = true;
         _loc3_.isNewDialog_1 = true;
         _loc4_.isNewDialog_1 = true;
         return [_loc1_,_loc2_,_loc3_,_loc4_];
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster();
         super.destroy();
      }
   }
}


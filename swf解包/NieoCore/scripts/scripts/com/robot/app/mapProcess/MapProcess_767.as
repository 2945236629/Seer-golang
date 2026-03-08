package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1203;
   import com.robot.app.task.taskscollection.Task1232;
   import com.robot.app.task.taskscollection.Task1235;
   import com.robot.core.CommandID;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.utils.CommonUI;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_767 extends BaseMapProcess
   {
      
      public function MapProcess_767()
      {
         super();
      }
      
      private function onComplete(param1:Event) : void
      {
         var e:Event = param1;
         SocketConnection.addCmdListener(CommandID.ITEM_LIST,function(param1:SocketEvent):void
         {
            var data:ByteArray;
            var e:SocketEvent = param1;
            SocketConnection.removeCmdListener(CommandID.ITEM_LIST,arguments.callee);
            data = e.data as ByteArray;
            if(data.readUnsignedInt() != 0)
            {
               NpcDialog.show(NPC.LEIYI,["好样的赛尔！你终于收集到了紫色极光之羽，快点击装置领取光之异能和雷神附体秘药吧！"],null,null,false,function():void
               {
                  CommonUI.addYellowArrow(topLevel,669,139,30);
               });
            }
         });
         SocketConnection.send(CommandID.ITEM_LIST,1200263,1200263,2);
      }
      
      override protected function init() : void
      {
         Task1232.initForMap767(this);
         Task1235.initForMap767(this);
         Task1203.initForMap767(this);
         SocketConnection.send(1022,86049344);
         MapListenerManager.add(btnLevel["fixture"],this.onFixtureClick,"雷光之翼");
         EventManager.addEventListener(Event.CLOSE,this.onComplete);
      }
      
      private function onClickKedu() : void
      {
         SocketConnection.send(1022,86049347);
         NpcDialog.show(NPC.KEDU,["赛尔，赛尔，自从雷伊受伤后，落日泥沼就电闪雷鸣。我好害怕呀，快点跟我去看一下。"],["不要害怕，我这就跟你去。","我等一下再过去。"],[function():void
         {
            SocketConnection.send(1022,86049348);
            MapManager.changeMap(759);
         }]);
      }
      
      private function onFixtureClick(param1:MouseEvent) : void
      {
         CommonUI.removeYellowArrow(topLevel);
         ModuleManager.showModule(ClientConfig.getAppModule("LeiGuangWings"),"正在加载...");
      }
      
      override public function destroy() : void
      {
         Task1232.destroy();
         Task1235.destroy();
         Task1203.destroy();
         EventManager.removeEventListener(Event.CLOSE,this.onComplete);
         CommonUI.removeYellowArrow(topLevel);
         super.destroy();
      }
   }
}


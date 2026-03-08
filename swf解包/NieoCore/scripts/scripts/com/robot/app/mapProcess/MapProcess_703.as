package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.StoneTowerController;
   import com.robot.core.CommandID;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.ItemXMLInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.ItemInBagAlert;
   import com.robot.core.utils.CommonUI;
   import com.robot.core.utils.TextFormatUtil;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_703 extends BaseMapProcess
   {
      
      public function MapProcess_703()
      {
         super();
      }
      
      override protected function init() : void
      {
         StoneTowerController.init(this);
      }
      
      override public function destroy() : void
      {
         StoneTowerController.destory();
      }
      
      public function exploitOre_0() : void
      {
         if(MainManager.actorInfo.clothIDs.indexOf(100014) != -1)
         {
            this.exploitOreStart(1,100014);
         }
         else if(MainManager.actorInfo.clothIDs.indexOf(100717) != -1)
         {
            this.exploitOreStart(1,100717);
         }
         else
         {
            NpcDialog.show(NPC.SEER,["咦！这些是什么？稀有碎片？我还是先收集点吧！说不定会有用的！"],["使用挖矿钻头采集！"]);
         }
      }
      
      public function exploitOre_1() : void
      {
         if(MainManager.actorInfo.clothIDs.indexOf(100014) != -1)
         {
            this.exploitOreStart(2,100014);
         }
         else if(MainManager.actorInfo.clothIDs.indexOf(100717) != -1)
         {
            this.exploitOreStart(2,100717);
         }
         else
         {
            NpcDialog.show(NPC.SEER,["咦！这些是什么？稀有碎片？我还是先收集点吧！说不定会有用的！"],["使用挖矿钻头采集！"]);
         }
      }
      
      private function exploitOreStart(param1:uint, param2:uint) : void
      {
         var i:uint = param1;
         var item:uint = param2;
         LevelManager.closeMouseEvent();
         MainManager.actorModel.specialAction(item);
         CommonUI.showProgressBar(topLevel,MainManager.actorModel.pos.x,MainManager.actorModel.pos.y - 70,function():void
         {
            SocketConnection.addCmdListener(CommandID.STONE_TOWER_GET_ENERGY,function(param1:SocketEvent):void
            {
               SocketConnection.removeCmdListener(CommandID.STONE_TOWER_GET_ENERGY,arguments.callee);
               LevelManager.openMouseEvent();
               var _loc3_:ByteArray = param1.data as ByteArray;
               var _loc4_:uint = _loc3_.readUnsignedInt();
               if(_loc4_ != 0)
               {
                  ItemInBagAlert.show(_loc4_,TextFormatUtil.getRedTxt("1个" + ItemXMLInfo.getName(_loc4_)) + "已经放入你的存储箱中。");
               }
            });
            SocketConnection.send(CommandID.STONE_TOWER_GET_ENERGY,i);
         });
      }
      
      public function onWallClick_0() : void
      {
         CommonUI.removeYellowArrow(topLevel);
         ModuleManager.showModule(ClientConfig.getAppModule("StoneTowerZisePanel"),"正在加载面板....");
      }
      
      public function onWallClick_1() : void
      {
         CommonUI.removeYellowArrow(topLevel);
         ModuleManager.showModule(ClientConfig.getAppModule("StoneTowerJinsePanel"),"正在加载面板....");
      }
   }
}


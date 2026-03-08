package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.panel.MapNamePanel;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alert;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10530 extends BaseMapProcess
   {
      
      private const MAX_DAMAGE:int = 40000;
      
      private const HURT_LIST:Array = [10000,24000,40000];
      
      private var _progress:int;
      
      private var _damage:int;
      
      private var _bonusStatus:int;
      
      private var _challengeInfo:Array;
      
      public function MapProcess_10530()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(btnLevel["bag"],this.onBagClick,"精灵背包");
         MapListenerManager.add(btnLevel["door"],this.onDoorClick,"离开历练");
         MapListenerManager.add(depthLevel["mcPet"],this.onPetClick,"点击直接挑战摩多");
         MapManager.addEventListener(MapEvent.MAP_SWITCH_OPEN,this.mapSwitchOpenHandler);
         ToolBarController.panel.visible = false;
         LevelManager.iconLevel.visible = false;
         MapNamePanel.hide();
         this.refreshHurt();
      }
      
      private function mapSwitchOpenHandler(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_OPEN,this.mapSwitchOpenHandler);
         SocketConnection.send(CommandID.MODO_GET_BONUS,4);
      }
      
      private function onBagClick(param1:MouseEvent) : void
      {
         PetBagControllerNew.showByBuffer();
      }
      
      private function onDoorClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("你确定要离开龙族秘境吗？离开后将重置当前历练进度哦！",function():void
         {
            MapManager.removeEventListener(MapEvent.MAP_SWITCH_OPEN,mapSwitchOpenHandler);
            SocketConnection.addCmdListener(CommandID.MODO_GET_BONUS,infoLeaveMapHandler);
            SocketConnection.send(CommandID.MODO_GET_BONUS,4);
         });
      }
      
      private function onPetClick(param1:MouseEvent) : void
      {
         FightManager.fightNoMapBoss("摩多",1442);
      }
      
      private function infoLeaveMapHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.MODO_GET_BONUS,this.infoLeaveMapHandler);
         MapManager.changeMap(674);
      }
      
      private function refreshHurt() : void
      {
         KTool.getMultiValue([16152,16153],function(param1:Array):void
         {
            if(mcProgress)
            {
               _damage = param1[0];
               _bonusStatus = param1[1];
               mcProgress.mcBar.gotoAndStop(int(_damage * mcProgress.mcBar.totalFrames / MAX_DAMAGE));
               ToolTipManager.remove(mcProgress.mcBar);
               ToolTipManager.add(mcProgress.mcBar,"已造成" + _damage + "点伤害");
               mcProgress.txtHurt.text = _damage + "/" + MAX_DAMAGE;
            }
         });
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.visible = true;
         LevelManager.iconLevel.visible = true;
         MapNamePanel.show();
      }
      
      private function get mcProgress() : MovieClip
      {
         if(Boolean(btnLevel) && Boolean(btnLevel["mcProgress"]))
         {
            return btnLevel["mcProgress"];
         }
         return null;
      }
   }
}


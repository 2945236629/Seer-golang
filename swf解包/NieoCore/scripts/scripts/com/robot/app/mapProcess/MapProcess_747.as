package com.robot.app.mapProcess
{
   import com.robot.app.control.GameStartController;
   import com.robot.app.games.GameStorageManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.GamePlatformManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_747 extends BaseMapProcess
   {
      
      public function MapProcess_747()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(conLevel["game"],"星际攀爬");
         conLevel["game"].addEventListener(MouseEvent.CLICK,this.onGameClick);
         ToolTipManager.add(conLevel["allGame"],"小游戏仓库");
         conLevel["allGame"].addEventListener(MouseEvent.CLICK,this.onAllGameClick);
         ToolTipManager.add(conLevel["ad_4"],"疯狂射击");
         conLevel["ad_4"].addEventListener(MouseEvent.CLICK,this.onShootClick);
      }
      
      private function onGameClick(param1:MouseEvent) : void
      {
         MapManager.removeAppArrow();
         GameStorageManager.freshLastGame(41016);
         GameStartController.show("flyStart","FlyeavesgowallGame");
      }
      
      private function onAllGameClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("GameStoragePanel"),"正在打开……");
      }
      
      private function onShootClick(param1:MouseEvent) : void
      {
         GamePlatformManager.join("CrazyShootGame",true,2);
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["game"]);
         ToolTipManager.remove(conLevel["allGame"]);
         conLevel["game"].removeEventListener(MouseEvent.CLICK,this.onGameClick);
         conLevel["allGame"].removeEventListener(MouseEvent.CLICK,this.onAllGameClick);
      }
   }
}


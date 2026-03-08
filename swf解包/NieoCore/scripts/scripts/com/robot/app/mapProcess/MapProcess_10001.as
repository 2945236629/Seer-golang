package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.mapProcess.control.mysteryHole.MysteryHoleControl;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10001 extends BaseMapProcess
   {
      
      public static var _mysteryHoleControl:MysteryHoleControl;
      
      private var mask_mc:MovieClip;
      
      private var _petBagBtn:MovieClip;
      
      private var backBtnMc:MovieClip;
      
      public function MapProcess_10001()
      {
         super();
      }
      
      private static function onJoinHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.MYSTERYHOLE_JOIN,onJoinHandler);
         _mysteryHoleControl.destroy();
         MapManager.changeLocalMap(10002);
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         MainManager.actorModel.hideNono();
         if(_mysteryHoleControl == null)
         {
            _mysteryHoleControl = new MysteryHoleControl();
            _mysteryHoleControl.queryPirate(int(MapManager.currentMap.id),MovieClip(depthLevel),0);
         }
         else
         {
            _mysteryHoleControl.queryPirate(int(MapManager.currentMap.id),MovieClip(depthLevel),1);
         }
         this.addMask();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalk);
         this.addBackBtn();
      }
      
      private function addMask() : void
      {
         this.mask_mc = MapManager.currentMap.libManager.getMovieClip("maskMc");
         this.mask_mc.mouseChildren = false;
         this.mask_mc.mouseEnabled = false;
         topLevel.cacheAsBitmap = true;
         this.onWalk(null);
         topLevel.addChildAt(this.mask_mc,0);
      }
      
      private function onWalk(param1:Event) : void
      {
         this.mask_mc.x = MainManager.actorModel.sprite.x;
         this.mask_mc.y = MainManager.actorModel.sprite.y;
      }
      
      private function addBackBtn() : void
      {
         this.backBtnMc = MapManager.currentMap.libManager.getMovieClip("backBtn");
         this.backBtnMc.x = 880;
         this.backBtnMc.y = 480;
         topLevel.addChild(this.backBtnMc);
         this.backBtnMc.addEventListener(MouseEvent.CLICK,this.onBackBtnMc);
         ToolTipManager.add(this.backBtnMc,"炫彩山");
         this._petBagBtn = MapManager.currentMap.libManager.getMovieClip("ui_Home_petBag_btn");
         this._petBagBtn.x = 800;
         this._petBagBtn.y = 480;
         this._petBagBtn.scaleX = this._petBagBtn.scaleY = 1.3;
         topLevel.addChild(this._petBagBtn);
         this._petBagBtn.buttonMode = true;
         this._petBagBtn.addEventListener(MouseEvent.CLICK,this.onClickPetBag);
         ToolTipManager.add(this._petBagBtn,"精灵背包");
      }
      
      private function onClickPetBag(param1:MouseEvent) : void
      {
         FightPetBagController.show(false,true);
      }
      
      private function onBackBtnMc(param1:MouseEvent) : void
      {
         this.backBtnMc.removeEventListener(MouseEvent.CLICK,this.onBackBtnMc);
         _mysteryHoleControl.onClickBtn();
      }
      
      public function gotoNextHoleHit() : void
      {
         SocketConnection.addCmdListener(CommandID.MYSTERYHOLE_JOIN,onJoinHandler);
         SocketConnection.send(CommandID.MYSTERYHOLE_JOIN,int(10002 - 10000));
      }
      
      override public function destroy() : void
      {
         this.backBtnMc.removeEventListener(MouseEvent.CLICK,this.onBackBtnMc);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalk);
         ToolTipManager.add(this._petBagBtn,"精灵背包");
         this._petBagBtn.removeEventListener(MouseEvent.CLICK,this.onClickPetBag);
         this._petBagBtn = null;
      }
   }
}


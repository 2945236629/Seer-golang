package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.ImageFightController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.info.pet.PetInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alert;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.AlignType;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10015 extends BaseMapProcess
   {
      
      private var _petMc:Array = [];
      
      private var _pos:Array = [new Point(92,232),new Point(222,176),new Point(382,144),new Point(582,144),new Point(742,176),new Point(870,232)];
      
      private var _panel:MovieClip;
      
      public function MapProcess_10015()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         ToolTipManager.add(topLevel["exit"],"空间裂缝");
         topLevel["exit"].addEventListener(MouseEvent.CLICK,this.onExitClick);
         depthLevel["start"].buttonMode = true;
         ToolTipManager.add(depthLevel["start"],"开始镜像挑战");
         depthLevel["start"].addEventListener(MouseEvent.CLICK,this.onStartClick);
         if(ImageFightController.isEnd)
         {
            this.showReward();
            return;
         }
         if(ImageFightController.stage <= 3)
         {
            this.loadPet(PetManager.infos.concat());
            if(ImageFightController.difficulty != 0)
            {
               ModuleManager.showModule(ClientConfig.getAppModule("ImageFightChoicePanel"),"正在加载面板....");
            }
         }
      }
      
      private function onExitClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("再次进入时需要重新挑战，确定要离开平行空间吗？",function():void
         {
            ImageFightController.leaveMap();
         });
      }
      
      private function onStartClick(param1:MouseEvent) : void
      {
         if(ImageFightController.isEnd)
         {
            return;
         }
         if(ImageFightController.difficulty == 0)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("ImageFightStartPanel"),"正在加载面板....");
         }
         else
         {
            ModuleManager.showModule(ClientConfig.getAppModule("ImageFightChoicePanel"),"正在加载面板....");
         }
      }
      
      private function showReward() : void
      {
         var _loc1_:MovieClip = null;
         this._panel = MapManager.currentMap.libManager.getMovieClip("fightEnd_ui");
         if(ImageFightController.isWin)
         {
            this._panel["win"].visible = true;
            this._panel["lose"].visible = false;
            _loc1_ = this._panel["win"];
         }
         else
         {
            this._panel["win"].visible = false;
            this._panel["lose"].visible = true;
            _loc1_ = this._panel["lose"];
         }
         this.setArtNum(ImageFightController.money,_loc1_,"money_");
         this.setArtNum(ImageFightController.exp,_loc1_,"exp_");
         this._panel["close"].addEventListener(MouseEvent.CLICK,this.onClose);
         LevelManager.appLevel.addChild(this._panel);
         DisplayUtil.align(this._panel,null,AlignType.MIDDLE_CENTER);
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._panel);
         ImageFightController.leaveMap();
      }
      
      private function setArtNum(param1:uint, param2:MovieClip, param3:String) : void
      {
         var _loc4_:String = param1.toString();
         while(_loc4_.length < 6)
         {
            _loc4_ = "0" + _loc4_;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < 6)
         {
            param2[param3 + _loc5_].gotoAndStop(uint(_loc4_.substr(_loc5_,1)) + 1);
            _loc5_++;
         }
      }
      
      private function loadPet(param1:Array) : void
      {
         var info:PetInfo = null;
         var pet:Array = param1;
         if(pet.length == 0)
         {
            if(ImageFightController.difficulty == 0)
            {
               this.playAnimate(true,0);
            }
            else
            {
               this.playAnimate(false,0);
            }
         }
         else
         {
            info = pet.shift() as PetInfo;
            ResourceManager.getResource(ClientConfig.getPetSwfPath(info.id),function(param1:DisplayObject):void
            {
               var _loc2_:MovieClip = param1 as MovieClip;
               _petMc.push(_loc2_);
               ToolTipManager.add(_loc2_,PetXMLInfo.getName(info.id));
               loadPet(pet);
            },"pet");
         }
      }
      
      private function playAnimate(param1:Boolean, param2:uint) : void
      {
         var isPlay:Boolean = param1;
         var index:uint = param2;
         if(index <= 5)
         {
            if(isPlay)
            {
               AnimateManager.playMcAnimate(conLevel["effect_" + index],0,"",function():void
               {
                  _petMc[index].x = _pos[index].x;
                  _petMc[index].y = _pos[index].y;
                  conLevel.addChild(_petMc[index]);
                  ++index;
                  playAnimate(isPlay,index);
               });
            }
            else
            {
               this._petMc[index].x = this._pos[index].x;
               this._petMc[index].y = this._pos[index].y;
               conLevel.addChild(this._petMc[index]);
               index++;
               this.playAnimate(isPlay,index);
            }
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._petMc)
         {
            ToolTipManager.remove(_loc1_);
         }
         this._petMc = null;
         this._pos = null;
         if(this._panel)
         {
            this._panel["close"].removeEventListener(MouseEvent.CLICK,this.onClose);
            this._panel = null;
         }
         ToolTipManager.remove(topLevel["exit"]);
         topLevel["exit"].removeEventListener(MouseEvent.CLICK,this.onExitClick);
         ToolTipManager.remove(depthLevel["start"]);
         depthLevel["start"].removeEventListener(MouseEvent.CLICK,this.onStartClick);
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         ModuleManager.destroy(ClientConfig.getAppModule("ImageFightStartPanel"));
         ModuleManager.destroy(ClientConfig.getAppModule("ImageFightChoicePanel"));
      }
   }
}


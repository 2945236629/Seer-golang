package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_798 extends BaseMapProcess
   {
      
      private var bossID:int;
      
      private var loaded:Boolean = false;
      
      private var level:int;
      
      private var _petMc:MovieClip;
      
      public function MapProcess_798()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.showOrHideAllUser(false);
         ToolBarController.panel.hide();
         DisplayUtil.removeAllChild(this.boss);
         if(BufferRecordManager.getState(MainManager.actorInfo,461))
         {
            this.prepare();
         }
         else
         {
            BufferRecordManager.setState(MainManager.actorInfo,461,true);
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("limitrulemc"),function():void
            {
               prepare();
            });
         }
         MapListenerManager.add(conLevel["bag"],function():void
         {
            FightPetBagController.show(false,true,true);
         },"精灵背包");
         MapListenerManager.add(conLevel["leave"],function():void
         {
            Alert.show("确定要离开极限法则吗？如果中途退出的话，下次需要从头开始挑战哦！",function():void
            {
               MapManager.changeMap(793);
            });
         },"离开场景");
      }
      
      private function prepare() : void
      {
         SocketConnection.addCmdListener(CommandID.LIMIT_RULE_LVINFO,function(param1:SocketEvent):void
         {
            var b:ByteArray;
            var e:SocketEvent = param1;
            SocketConnection.removeCmdListener(CommandID.LIMIT_RULE_LVINFO,arguments.callee);
            b = e.data as ByteArray;
            bossID = b.readUnsignedInt();
            level = b.readUnsignedInt();
            if(bossID == 0)
            {
               Alarm.show("恭喜你完成所有挑战！",function():void
               {
                  MapManager.changeMap(793);
               });
               return;
            }
            EventManager.addEventListener(ResourceManager.RESOUCE_ERROR,onLoadPet);
            onLoadPet();
         });
         SocketConnection.send(CommandID.LIMIT_RULE_LVINFO);
      }
      
      private function onLoadPet(param1:* = null) : void
      {
         if(this.loaded)
         {
            return;
         }
         ResourceManager.getResource(ClientConfig.getPetSwfPath(this.bossID),this.onComHandler,"pet");
      }
      
      private function onComHandler(param1:DisplayObject) : void
      {
         var mc:DisplayObject = param1;
         var playMC:Function = function():void
         {
            mainMC["mc"].play();
            conLevel.addEventListener(Event.ENTER_FRAME,onAddPet);
            conLevel.addEventListener(Event.ENTER_FRAME,onCheckTitle);
            MapListenerManager.add(boss,function():void
            {
               SocketConnection.send(CommandID.LIMIT_RULE_FIGHT);
            });
         };
         this.loaded = true;
         this._petMc = mc as MovieClip;
         DisplayUtil.stopAllMovieClip(this._petMc);
         if(this.level == 1)
         {
            playMC();
         }
         else
         {
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function():void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               playMC();
            });
         }
      }
      
      private function onAddPet(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MovieClip = this.mainMC["mc"];
         if(!this._petMc.parent && _loc2_ && _loc2_.currentFrame > 15)
         {
            this.boss.addChild(this._petMc);
         }
         if(Boolean(_loc2_) && _loc2_.currentFrame == _loc2_.totalFrames)
         {
            conLevel.removeEventListener(Event.ENTER_FRAME,this.onAddPet);
            _loc3_ = (this.level - 1) / 5 + 1;
            this.mainMC.gotoAndStop(_loc3_ + 1);
         }
      }
      
      private function onCheckTitle(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.mainMC["mc"]) && Boolean(this.mainMC["mc"]["title"]))
         {
            _loc2_ = this.level % 5;
            if(_loc2_ == 0)
            {
               _loc2_ = 5;
            }
            this.mainMC["mc"]["title"].gotoAndStop(_loc2_);
         }
      }
      
      private function get mainMC() : MovieClip
      {
         return topLevel["mainMC"];
      }
      
      private function get boss() : MovieClip
      {
         return topLevel["bossContainer"];
      }
      
      override public function destroy() : void
      {
         EventManager.removeEventListener(ResourceManager.RESOUCE_ERROR,this.onLoadPet);
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         conLevel.removeEventListener(Event.ENTER_FRAME,this.onCheckTitle);
         conLevel.removeEventListener(Event.ENTER_FRAME,this.onAddPet);
         super.destroy();
      }
   }
}


package com.robot.app.galaxy
{
   import com.robot.core.*;
   import com.robot.core.config.xml.*;
   import com.robot.core.info.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.*;
   import com.robot.core.net.*;
   import com.robot.core.ui.mapTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import org.taomee.events.SocketEvent;
   import org.taomee.utils.*;
   
   public class Galaxy_3 extends Sprite
   {
      
      private static const MAP_TOTAL_WIDTH:Number = 1500;
      
      private static const MAP_VISIBLE_WIDTH:Number = 825 - 124;
      
      private static const MAX_SCROLL_X:Number = MAP_TOTAL_WIDTH - MAP_VISIBLE_WIDTH;
      
      private static const MIN_SCROLL_X:Number = 0;
      
      private static const SCROLL_STEP:Number = 200;
      
      private var intervalId:uint;
      
      private var myIcon:MovieClip;
      
      private var mapScrollRect:Rectangle;
      
      private var target:Number = 0;
      
      private var mc:MovieClip;
      
      private var isHited:Boolean = false;
      
      private var mapMC:MovieClip;
      
      private var _loader:Loader;
      
      private var isDragging:Boolean = false;
      
      private var lastMouseX:Number = 0;
      
      private var initialScrollX:Number = 0;
      
      private var hotMCArray:Array = [];
      
      private var perHot:uint = 10;
      
      public function Galaxy_3()
      {
         super();
      }
      
      public function destroy() : void
      {
         this.hide();
         SocketConnection.removeCmdListener(CommandID.MAP_HOT,this.onGetMapHot);
         for each(var old in this.hotMCArray)
         {
            if(old && old.parent)
            {
               old.parent.removeChild(old);
            }
         }
         this.hotMCArray = [];
         this.mc = null;
         this.mapMC = null;
      }
      
      public function hide() : void
      {
         DisplayUtil.removeForParent(this.mc,false);
         this.isHited = false;
      }
      
      public function show() : void
      {
         this.initGalaxy();
      }
      
      private function initGalaxy() : void
      {
         var _loc1_:SimpleButton = null;
         var _loc2_:uint = 0;
         var _loc3_:* = null;
         var _loc4_:uint = uint(this.mc.numChildren);
         var _loc5_:int = 0;
         try
         {
            while(_loc5_ < _loc4_)
            {
               _loc1_ = this.mc.getChildAt(_loc5_) as SimpleButton;
               if(Boolean(_loc1_))
               {
                  _loc1_.addEventListener(MouseEvent.CLICK,this.changeMap);
                  _loc2_ = uint(_loc1_.name.split("_")[1]);
                  _loc3_ = MapConfig.getName(_loc2_) + "\r<font color=\'#ff0000\'>" + MapConfig.getDes(_loc2_) + "</font>";
                  _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onMosOver);
                  _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onMosOut);
               }
               _loc5_++;
            }
         }
         catch(error:Error)
         {
         }
         this.getHot();
      }
      
      private function changeMap(param1:MouseEvent) : void
      {
         var _loc2_:String = (param1.currentTarget as SimpleButton).name;
         var _loc3_:uint = uint(_loc2_.split("_")[1]);
         MapManager.changeMap(_loc3_);
      }
      
      public function setup(param1:Loader) : void
      {
         this._loader = param1;
         this.mc = new (Utils.getClassFromLoader("galaxy_plant_3",this._loader) as Class)();
         this.mc.cacheAsBitmap = true;
         addChild(this.mc);
         this.mc.x = 122;
         this.mc.y = 144;
         this.mapScrollRect = new Rectangle(0,0,763,260);
         this.myIcon = new (Utils.getClassFromLoader("galaxy_my_icon",this._loader) as Class)();
         this.myIcon.mouseChildren = false;
         this.myIcon.mouseEnabled = false;
         DisplayUtil.FillColor(this.myIcon["mc"]["colorMC"],MainManager.actorInfo.color);
      }
      
      public function init(param1:Object = null) : void
      {
         this.mapMC = param1 as MovieClip;
         (this.mapMC["nextBtn"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onNextBtn);
         (this.mapMC["prevBtn"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onPrevBtn);
      }
      
      private function onNextBtn(param1:MouseEvent) : void
      {
         if(this.mapScrollRect.x >= MAX_SCROLL_X)
         {
            this.mapScrollRect.x = MAX_SCROLL_X;
            this.mc.scrollRect = this.mapScrollRect;
            return;
         }
         this.mapScrollRect.x += SCROLL_STEP;
         if(this.mapScrollRect.x > MAX_SCROLL_X)
         {
            this.mapScrollRect.x = MAX_SCROLL_X;
         }
         this.mc.scrollRect = this.mapScrollRect;
      }
      
      private function onPrevBtn(param1:MouseEvent) : void
      {
         if(this.mapScrollRect.x <= MIN_SCROLL_X)
         {
            this.mapScrollRect.x = MIN_SCROLL_X;
            this.mc.scrollRect = this.mapScrollRect;
            return;
         }
         this.mapScrollRect.x -= SCROLL_STEP;
         if(this.mapScrollRect.x < MIN_SCROLL_X)
         {
            this.mapScrollRect.x = MIN_SCROLL_X;
         }
         this.mc.scrollRect = this.mapScrollRect;
      }
      
      private function onMouseDownMap(param1:MouseEvent) : void
      {
         if(this.mc == null || this.mapScrollRect == null)
         {
            return;
         }
         this.isDragging = true;
         this.lastMouseX = MainManager.getStage().mouseX;
         this.initialScrollX = this.mapScrollRect.x;
         MainManager.getStage().addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveMap);
         MainManager.getStage().addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpMap);
         param1.stopPropagation();
      }
      
      private function onMouseMoveMap(param1:MouseEvent) : void
      {
         if(!this.isDragging)
         {
            return;
         }
         var _loc2_:Number = Number(MainManager.getStage().mouseX);
         var _loc3_:Number = _loc2_ - this.lastMouseX;
         var _loc4_:Number = this.initialScrollX - _loc3_;
         _loc4_ = Math.max(MIN_SCROLL_X,_loc4_);
         _loc4_ = Math.min(MAX_SCROLL_X,_loc4_);
         this.mapScrollRect.x = _loc4_;
         this.mc.scrollRect = this.mapScrollRect;
         this.lastMouseX = _loc2_;
         param1.stopPropagation();
      }
      
      private function onMouseUpMap(param1:MouseEvent) : void
      {
         this.isDragging = false;
         MainManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveMap);
         MainManager.getStage().removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpMap);
         param1.stopPropagation();
      }
      
      public function getHot() : void
      {
         SocketConnection.addCmdListener(CommandID.MAP_HOT,this.onGetMapHot);
         SocketConnection.mainSocket.send(CommandID.MAP_HOT,[]);
         this.initMyPostion();
      }
      
      private function onMosOver(param1:MouseEvent) : void
      {
         var id:uint = 0;
         var evt:MouseEvent = param1;
         var btn:SimpleButton = evt.currentTarget as SimpleButton;
         id = uint(btn.name.split("_")[1]);
         this.intervalId = setTimeout(function():void
         {
            MapTip.show(new MapTipInfo(id));
         },500);
      }
      
      private function onGetMapHot(param1:SocketEvent) : void
      {
         var btn:SimpleButton = null;
         var insertIndex:int = int(this.mapMC.getChildIndex(this.mapMC["galaxyMC"]));
         this.mapMC.addChildAt(this.mc,insertIndex + 1);
         SocketConnection.removeCmdListener(CommandID.MAP_HOT,this.onGetMapHot);
         var info:MapHotInfo = param1.data as MapHotInfo;
         for each(var old in this.hotMCArray)
         {
            if(old && old.parent)
            {
               old.parent.removeChild(old);
            }
         }
         this.hotMCArray = [];
         var childCount:uint = uint(this.mc.numChildren);
         var i:uint = 0;
         while(i < childCount)
         {
            btn = this.mc.getChildAt(i) as SimpleButton;
            if(Boolean(btn))
            {
               var mapId:uint = uint(btn.name.split("_")[1]);
               var hotValue:uint = uint(info.infos.getValue(mapId));
               if(hotValue > 0)
               {
                  var level:uint = Math.ceil(hotValue / this.perHot);
                  if(level > 5)
                  {
                     level = 5;
                  }
                  var k:uint = 0;
                  while(k < level)
                  {
                     var bar:MovieClip = new MovieClip();
                     bar.mouseEnabled = false;
                     bar.mouseChildren = false;
                     bar.graphics.beginFill(16737792,0.9);
                     bar.graphics.drawRect(0,0,6,6);
                     bar.graphics.endFill();
                     bar.x = btn.x + btn.width * 0.5 + 8;
                     bar.y = btn.y - 4 - k * 7;
                     this.mc.addChild(bar);
                     this.hotMCArray.push(bar);
                     k++;
                  }
               }
            }
            i++;
         }
      }
      
      private function initMyPostion() : void
      {
         var _loc1_:Point = SuperMapXMLInfo.getWorldMapPos(MapConfig.getSuperMapID(MainManager.actorInfo.mapID));
         var _loc2_:uint = uint(SuperMapXMLInfo.getCurrentGalaxy(MapConfig.getSuperMapID(MainManager.actorInfo.mapID)));
         if(Boolean(_loc1_))
         {
            if(_loc2_ == 3)
            {
               if(_loc1_.x != 0 || _loc1_.y != 0)
               {
                  this.myIcon.x = _loc1_.x;
                  this.myIcon.y = _loc1_.y;
                  this.mc.addChild(this.myIcon);
               }
            }
            else
            {
               DisplayUtil.removeForParent(this.myIcon);
            }
         }
         else
         {
            DisplayUtil.removeForParent(this.myIcon);
         }
      }
      
      private function onMosOut(param1:MouseEvent) : void
      {
         clearTimeout(this.intervalId);
         MapTip.hide();
      }
   }
}


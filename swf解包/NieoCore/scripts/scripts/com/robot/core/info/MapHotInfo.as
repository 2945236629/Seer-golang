package com.robot.core.info
{
   import flash.utils.IDataInput;
   import org.taomee.ds.HashMap;
   
   public class MapHotInfo
   {
      
      private var _infos:HashMap;
      
      public function MapHotInfo(input:IDataInput)
      {
         super();
         this._infos = new HashMap();
         if(input == null || input.bytesAvailable < 4)
         {
            return;
         }
         var count:uint = uint(input.readUnsignedInt());
         var i:uint = 0;
         var maxByBytes:uint = uint(input.bytesAvailable / 8);
         if(count > maxByBytes)
         {
            count = maxByBytes;
         }
         while(i < count)
         {
            var mapID:uint = uint(input.readUnsignedInt());
            var hotValue:uint = uint(input.readUnsignedInt());
            this._infos.add(mapID,hotValue);
            i++;
         }
      }
      
      public function get infos() : HashMap
      {
         return this._infos;
      }
   }
}

